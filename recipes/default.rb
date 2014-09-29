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

include_recipe 'apt'
include_recipe 'git'
include_recipe 'cron'
include_recipe 'ntp'
include_recipe 'logrotate'
include_recipe 'vim'

node['eas-base']['all_users'].each do |user_group|
  users_manage user_group do
    data_bag 'users'
  end
end

include_recipe 'sudo'
include_recipe 'postfix'

include_recipe 'eas-base::_rsyslog'

include_recipe 'nrpe'
include_recipe 'eas-base::_base_monitoring'

include_recipe 'eas-base::_route53' if node.attribute?('ec2')
include_recipe 'chef-client::cron'
