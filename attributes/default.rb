default['eas-base']['ops_group'] = 'sysadmin'
default['eas-base']['dev_group'] = 'dev'
default['eas-base']['apps_group'] = 'www-data'
default['eas-base']['all_users'] = [node['eas-base']['ops_group'], node['eas-base']['dev_group'], node['eas-base']['apps_group']]
