#
# Cookbook:: golob-taskmanager
# Recipe:: airflow
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'airflow::default'

execute 'airflow initdb' do
  creates "#{node['airflow']['config']['core']['airflow_home']}/airflow.db"
  command "#{node['airflow']['bin_path']}/airflow initdb"
  user node['airflow']['user']
  environment 'AIRFLOW_HOME' => \
    node['airflow']['config']['core']['airflow_home']
end

include_recipe 'airflow::webserver'

service 'airflow-webserver' do
  action [:start]
end
