default['eas-base']['ops_group'] = 'sysadmin'
default['eas-base']['dev_group'] = 'dev'
default['eas-base']['apps_group'] = 'www-data'
default['eas-base']['all_users'] = [node['eas-base']['ops_group'], node['eas-base']['dev_group'], node['eas-base']['apps_group']]

default['authorization']['sudo']['groups'] = [node['eas-base']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users']  = %w(ubuntu vagrant)

# logstash server port
normal['rsyslog']['server_search'] = 'role:loghost'
normal['rsyslog']['port'] = 5959
normal['rsyslog']['enable_tls'] = true
normal['rsyslog']['tls_ca_file'] = '/etc/pki/tls/certs/logstash.crt'

normal['postfix']['main']['smtp_use_tls'] = 'yes'
normal['postfix']['main']['smtp_tls_CAfile'] = node['rsyslog']['tls_ca_file']
normal['postfix']['main']['smtp_tls_session_cache_database'] = 'btree:${data_directory}/smtp_scache'

normal['apt']['compile_time_update'] = true
# parameters used for route53
default['eas-base']['hosted_domain'] = 'eas.promethost.com'
default['eas-base']['zone_id'] = 'Z17UO48EJODEL9'

# chef-client attributes
normal['chef_client']['init_style'] = 'none'
normal['chef_client']['cron']['minute'] = '*/20'
normal['chef_client']['cron']['hour'] = '*'
