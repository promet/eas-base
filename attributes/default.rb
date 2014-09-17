default['_user']['ops_group'] = 'ops'
# default['_user']['ops_group_id'] = 1100
default['_user']['apps_group'] = 'apps'
# default['_user']['apps_group_id'] = 2100
default['_user']['all_users'] = [ node['_user']['ops_group'], node['_user']['apps_group'] ]

default['authorization']['sudo']['groups'] = [node['_user']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users']  = ['ubuntu']
default['authorization']['sudo']['users']  = ['vagrant']
