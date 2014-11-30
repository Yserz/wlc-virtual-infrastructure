log_level                :info
log_location             STDOUT
node_name                'container-local-workstation'
client_key               '/etc/chef/client.pem'
chef_server_url          'https://192.168.1.2:9191/'
syntax_check_cache_path  '/home/vagrant/.chef/syntax_check_cache'
cookbook_path [ '/home/vagrant/chef-repo//cookbooks' ]