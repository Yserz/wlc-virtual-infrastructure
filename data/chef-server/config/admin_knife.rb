log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/etc/chef-server/admin.pem'
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://vm-chef-server:9191/'
syntax_check_cache_path  '~/.chef/syntax_check_cache'
cookbook_path [ '/vagrant/chef-repo//cookbooks' ]