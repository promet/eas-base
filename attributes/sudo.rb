default['authorization']['sudo']['groups'] = [node['eas-base']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users'] = %w(ubuntu vagrant)
