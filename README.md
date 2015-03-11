# oc_id_application

A library cookbook that provides the oc_id_application resource that is used
to configure oc-id applications on a Chef Server.  Requires a local version
of the oc_id application to be installed in order to function.

## License

All files in the repository are licensed under the Apache 2.0 license. If any
file is missing the License header it should assume the following is attached;

```
Copyright 2015 Chef Software Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Usage

```ruby
# recipe.rb
oc_id_application 'supermarket' do
  redirect_uri      'http://supermarket.myorg.com/auth/chef_oauth2/callback'
  oc_id_install_dir '/opt/opscode/embedded/service/oc_id'
  action :create
end
```
