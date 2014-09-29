nrpe_check 'check_load' do
  command "#{node['nrpe']['plugin_dir']}/check_load"
  warning_condition '6'
  critical_condition '10'
  action :add
end

# Check all non-NFS/tmp-fs disks.
nrpe_check 'check_all_disks' do
  command "#{node['nrpe']['plugin_dir']}/check_disk"
  warning_condition '10%'
  critical_condition '5%'
  parameters '-A -x /dev/shm -X nfs -i /boot'
  action :add
end
