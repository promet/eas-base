directory '/etc/pki/tls/certs' do
  recursive true
  user 'root'
  group 'root'
  mode 00655
  action :create
end

cookbook_file '/etc/pki/tls/certs/logstash.crt' do
  source 'logstash.crt'
  owner 'root'
  group 'root'
  mode 0644
end

include_recipe 'rsyslog::client'

cookbook_file '/etc/rsyslog.d/21-nginx.conf' do
  source '21-nginx.conf'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{node['rsyslog']['service_name']}]"
end
