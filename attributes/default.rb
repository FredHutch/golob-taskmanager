default['nginx']['default_site_enabled'] = false
default['golob-taskmanager'] = {
  'server_name' => 'gt-test',
  'ssl_cert' => '/etc/nginx/cert.pem',
  'ssl_cert_key' => '/etc/nginx/cert_key.pem'
}
