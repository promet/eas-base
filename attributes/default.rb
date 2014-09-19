default['_user']['ops_group'] = 'ops'
default['_user']['apps_group'] = 'apps'
default['_user']['all_users'] = [ node['_user']['ops_group'], node['_user']['apps_group'] ]

default['authorization']['sudo']['groups'] = [node['_user']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users']  = ['ubuntu']
default['authorization']['sudo']['users']  = ['vagrant']

# used for Chef Solo only
normal['rsyslog']['server_ip'] = '33.33.33.10'

# logstash server port
normal['rsyslog']['port'] = 5959
normal['rsyslog']['enable_tls'] = true
normal['rsyslog']['tls_ca_file'] = '/etc/pki/tls/certs/logstash.crt'
