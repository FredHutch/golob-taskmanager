#
# Cookbook:: golob-taskmanager
# Recipe:: luigi
#
# Copyright:: 2017, The Authors, All Rights Reserved.

python_runtime '3'
python_virtualenv '/opt/luigi'

python_package 'luigi'

# Create basic luigi directories

directory '/var/lib/luigi-server' do
  owner 'root'
  group 'root'
  mode '0755'
end

execute 'enable luigid systemd unit' do
  command '/bin/systemctl enable luigid.service'
  action :nothing
end

template '/lib/systemd/system/luigid.service' do
  source 'luigid.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :run, 'execute[enable luigid systemd unit]', :immediately
end

service 'luigid' do
  action :start
end
