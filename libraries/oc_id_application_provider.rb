require 'chef/provider/lwrp_base'

class Chef
  class Provider
    # oc_id_application provider
    class OcIdApplication < Chef::Provider::LWRPBase
      include Chef::Mixin::ShellOut

      use_inline_resources if defined?(:use_inlined_resources)

      action :create do
        converge_by "create oc-id application '#{new_resource.name}'" do
          attributes = create!

          directory new_resource.config_dir do
            owner 'root'
            group 'root'
            mode '0755'
          end

          file File.join(new_resource.config_dir, "#{new_resource.name}.json") do
            content Chef::JSONCompat.to_json_pretty(attributes)
            owner 'root'
            group 'root'
            mode '0600'
          end
        end
      end

      private

      def create!
        @attributes ||= begin
          rails_script = <<EOF
app = Doorkeeper::Application.find_or_create_by(:name => "#{new_resource.name}");
app.update_attributes(:redirect_uri => "#{new_resource.redirect_uri}");
puts app.to_json
EOF
          # in order to account for rails logging, we take only the last line of output
          # from the rails runner script. if the logging is parsed as json, we end up
          # with a difficult-to-comprehend error message that looks like:
          #
          # ```
          # Chef::Exceptions::JSON::ParseError: lexical error: invalid char in json text.
          #                            I, [2015-05-07T18:26:37.236655
          #          (right here) ------^
          # ```
          json = shell_out!("bin/rails runner -e production '#{rails_script}'",
                            cwd: new_resource.oc_id_install_dir).stdout.lines.last.chomp

          Chef::JSONCompat.from_json(json).delete_if { |key| %w(id created_at updated_at).include? key }
        end
      end
    end
  end
end
