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

systemd_unit 'luigid.service' do
  content <<-EREH.gsub(/^\s+/, '')
    [Unit]
    Description=Luigi Scheduler Daemon
    After=network.target

    [Service]
    ExecStart=/opt/luigi/bin/luigid --pidfile /var/run/luigi-server.pid --logdir=/var/log --state=path=/var/lib/luigi-server
    ExecReload=/bin/kill -HUP $MAINPID
    KillMode=process
    Restart=on-failure
    RestartPreventExitStatus=255
    Type=notify

    [Install]
    WantedBy=multi-user.target
    Alias=luigid.service
  EREH
  action [:create, :enable]
end
