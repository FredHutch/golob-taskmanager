#
# Cookbook:: golob-taskmanager
# Recipe:: default
#
# Copyright:: 2017, Fred Hutchinson CRC, All Rights Reserved.

include_recipe 'nginx::default'
include_recipe 'chef-vault'

# load secrets from vault

tls_data = chef_vault_item(
  node['golob-taskmanager']['server_name'], 'certificate'
)
key = tls_data['key']
cert = tls_data['certificate']

# create certificate files
file node['golob-taskmanager']['ssl_cert'] do
  mode '0644'
  owner 'root'
  group 'root'
  content cert
end

file node['golob-taskmanager']['ssl_cert_key'] do
  mode '0600'
  owner 'root'
  group 'root'
  content key
end

directory "/var/log/sites-#{node['golob-taskmanager']['server_name']}" do
  mode '0755'
  owner 'www-data'
  group 'root'
end

nginx_site 'taskmanager' do
  template 'nginx/taskmanager.erb'
  variables(
    'server_name' => node['golob-taskmanager']['server_name'],
    'logdir' => \
      "/var/log/sites-#{node['golob-taskmanager']['server_name']}",
    'ssl_cert' => node['golob-taskmanager']['ssl_cert'],
    'ssl_cert_key' => node['golob-taskmanager']['ssl_cert_key']
  )
end
