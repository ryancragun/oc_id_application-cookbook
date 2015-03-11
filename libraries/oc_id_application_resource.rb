require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # oc_id_application resource
    class OcIdApplication < Chef::Resource::LWRPBase
      self.resource_name = 'oc_id_application'

      actions :create
      default_action :create

      attribute :name, kind_of: String, name_attribute: true
      attribute :redirect_uri, kind_of: String, required: true
      attribute :oc_id_install_dir,
                kind_of: String,
                default: '/opt/opscode/embedded/service/oc_id'
    end
  end
end
