# eas-base-cookbook

Base cookbook sets up users, enables sudo for specific groups, installs postfix and configures rsyslog for log transport to logstash server. Uses encryption for transport

## Supported Platforms

Ubuntu 14.04 (may work on other versions of Ubuntu, but target release is 14.04).

## Attributes
```
default['_user']['ops_group'] = 'ops'
default['_user']['apps_group'] = 'apps'
default['_user']['all_users'] = [ node['_user']['ops_group'], node['_user']['apps_group'] ]

default['authorization']['sudo']['groups'] = [node['_user']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users']  = ['ubuntu', 'vagrant']

# used for Chef Solo only
default['rsyslog']['server_ip'] = '33.33.33.10'

# logstash server port
normal['rsyslog']['port'] = 5959
normal['rsyslog']['enable_tls'] = true
normal['rsyslog']['tls_ca_file'] = '/etc/pki/tls/certs/logstash.crt'
```

## Usage

### eas-base::default

Include `eas-base` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[eas-base::default]"
  ]
}
```

## License and Authors

Author:: opscale (<cookbooks@opscale.com>)
