#
# Cookbook Name:: eas-base
# Recipe:: default
#
# Copyright (C) 2014 opscale
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# add additional user
include_recipe 'users'

node['_user']['all_users'].each do |user_group|
  users_manage user_group do
    data_bag 'users'
  end
end

include_recipe 'sudo'
include_recipe 'postfix'

directory '/etc/pki/tls/certs' do
  recursive true
  user 'root'
  group 'root'
  mode 00655
  action :create
end

cookbook_file '/etc/pki/tls/certs/logstash.crt' do
  source 'logstash.crt'
  owner 'root'
  group 'root'
  mode 0644
end

include_recipe 'rsyslog::client'
