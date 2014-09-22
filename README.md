# eas-base-cookbook

Base cookbook sets up users, enables sudo for specific groups. User information is stored in data bags. Installs postfix and configures rsyslog for log transport to logstash server - uses encryption for transport.

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
Although this cookbook can be deployed standalone, it is meant to be combined with other cookbooks such as eas-jenkins eas-lemp.

To bootstrap a jenkins server on AWS you may run a knife command like:

```
knife ec2  server create --flavor t2.micro --image  ami-864d84ee --associate-public-ip --subnet "SUBNET" --ssh-key KEYPAIR_NAME --run-list "recipe[eas-base::default],recipe[eas-jenkins::default]" --security-group-ids SECURITY_GROUP_ID -x ubuntu -i PATH_TO_KEY_PAIR_FILE
```

## Security

Currently the certificate and the key necessary for the encrypted communication between the logstash host and the rsyslog clients are part of this repository. This is acceptable for testing, but will be changed for production. 
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
