# eas-base-cookbook

Base cookbook sets up users, enables sudo for specific groups. User information is stored in data bags. Installs postfix and configures rsyslog for log transport to logstash server - uses encryption for transport. When run on AWS it will create two entries in route53:
- nodename
- nodename-dev


## Supported Platforms

Ubuntu 14.04 (may work on other versions of Ubuntu, but target release is 14.04).

## Attributes
The eas-base cookbooks creates a few local attributes and overwrites several attributes of the included cooksbooks:

```
default['eas-base']['ops_group'] = 'sysadmin'
default['eas-base']['dev_group'] = 'dev'
default['eas-base']['apps_group'] = 'www-data'
default['eas-base']['all_users'] = [node['eas-base']['ops_group'], node['eas-base']['dev_group'], node['eas-base']['apps_group']]

# parameters used for route53
default['eas-base']['route53']['hosted_domain'] = 'eas.promethost.com'
default['eas-base']['route53']['zone_id'] = 'Z17UO48EJODEL9'
```
Mostly required for the route53 cookbook:
```
['apt']['compile_time_update']
```
To setup chef-client as a cron job:
```
normal['chef_client']['init_style'] = 'none'
normal['chef_client']['cron']['minute'] = '*/20'
normal['chef_client']['cron']['hour'] = '*'
```
Essentials for postfix:
```
normal['postfix']['main']['smtp_use_tls'] = 'yes'
normal['postfix']['main']['smtp_tls_CAfile'] = node['rsyslog']['tls_ca_file']
normal['postfix']['main']['smtp_tls_session_cache_database'] = 'btree:${data_directory}/smtp_scache'
```
Setting up the connectivity to the logstash server (eas-base will search for a server with the role loghost by default):
```
normal['rsyslog']['server_search'] = 'role:loghost'
normal['rsyslog']['port'] = 5959
normal['rsyslog']['enable_tls'] = true
normal['rsyslog']['tls_ca_file'] = '/etc/pki/tls/certs/logstash.crt'
```
Overwrites for the sudo cookbook:
```
default['authorization']['sudo']['groups'] = [node['eas-base']['ops_group']]
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users'] = %w(ubuntu vagrant)
```

## Usage
Although this cookbook can be deployed standalone, it is meant to be combined with other cookbooks such as eas-jenkins eas-lemp.

To bootstrap a jenkins server on AWS you may run a knife command like:

```
knife ec2  server create [--node-name NODENAME] --flavor t2.micro --image  ami-864d84ee --associate-public-ip --subnet "SUBNET" --ssh-key KEYPAIR_NAME --run-list "recipe[eas-base::default],recipe[eas-jenkins::default]" --security-group-ids SECURITY_GROUP_ID -x ubuntu -i PATH_TO_KEY_PAIR_FILE
```
## route53
In order to work correctly a data bag item named aws_dns_admin needs to get uploaded to the secrets data bag on the chef server:
```
{
  "id": "aws_dns_admin",
  "aws_access_key_id": "YOUR_AWS_ACCESS_KEY_ID",
  "aws_secret_access_key": "YOUR_AWS_SECRET_ACCESS_KEY"
}
```
The AWS user needs to have the AmazonRoute53FullAccess policy enabled:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:DescribeLoadBalancers"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
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
