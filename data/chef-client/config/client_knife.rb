log_level                :info
log_location             STDOUT
client_key               '/etc/chef/client.pem'
chef_server_url          'https://192.168.1.2:9191/'
ssl_verify_mode          :verify_none
syntax_check_cache_path  '/home/vagrant/.chef/syntax_check_cache'
cookbook_path [ '/vagrant/wlc-chef-repo/cookbooks' ]