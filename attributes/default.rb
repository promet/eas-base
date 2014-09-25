default['_user']['ops_group'] = 'sysadmin'
default['_user']['dev_group'] = 'dev'
default['_user']['apps_group'] = 'www-data'
default['_user']['all_users'] = [node['_user']['ops_group'], node['_user']['dev_group'], node['_user']['apps_group']]

default['authorization']['sudo']['groups'] = [node['_user']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users']  = %w(ubuntu vagrant)

# used for Chef Solo only
default['rsyslog']['server_ip'] = '33.33.33.10'

# logstash server port
normal['rsyslog']['port'] = 5959
normal['rsyslog']['enable_tls'] = true
normal['rsyslog']['tls_ca_file'] = '/etc/pki/tls/certs/logstash.crt'

normal['postfix']['main']['smtp_use_tls'] = 'yes'
normal['postfix']['main']['smtp_tls_CAfile'] = node['rsyslog']['tls_ca_file']
normal['postfix']['main']['smtp_tls_session_cache_database'] = 'btree:${data_directory}/smtp_scache'

normal['nagios']['server_role'] = 'nagios-server'
normal['nagios']['multi_environment_monitoring'] = 'true'

normal['apt']['compile_time_update'] = true
# parameters used for route53
default['eas-base']['hosted_domain'] = 'eas.promethost.com'
default['eas-base']['zone_id'] = 'Z17UO48EJODEL9'

# chef-client attributes
normal['chef_client']['init_style'] ='none'
normal['chef_client']['cron']['minute'] = '*/20'
normal['chef_client']['cron']['hour'] = '*'
