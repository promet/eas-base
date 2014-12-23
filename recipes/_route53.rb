include_recipe 'route53'

aws_dns_admin = data_bag_item('secrets', 'aws_dns_admin')

dns_entry1 = node.name.to_s + '.' + node['route53']['hosted_domain'].to_s
dns_entry2 = node.name.to_s + '-dev.' + node['route53']['hosted_domain'].to_s
node['ec2'].attribute?('public_ipv4') ? dns_value = node['ec2']['public_ipv4'] : dns_value = node['ipaddress']

route53_record 'create a record' do
  name dns_entry1
  value dns_value
  type 'A'
  zone_id node['route53']['zone_id']
  aws_access_key_id aws_dns_admin['aws_access_key_id']
  aws_secret_access_key aws_dns_admin['aws_secret_access_key']
  overwrite true
  action :create
end

route53_record 'create a record' do
  name dns_entry2
  value dns_value
  type 'CNAME'
  zone_id node['route53']['zone_id']
  aws_access_key_id aws_dns_admin['aws_access_key_id']
  aws_secret_access_key aws_dns_admin['aws_secret_access_key']
  overwrite true
  action :create
end
