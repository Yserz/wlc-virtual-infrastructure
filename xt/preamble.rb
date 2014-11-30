require 'vagrant.rb'


class Preamble
  @installedPlugin
  attr_accessor :is_windows
  @is_windows
  
  def initialize(config)
    Vagrant.require_version ">= 1.6.5"
  
    # Detects Windows ;P
    @is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    @installedPlugin = false
    
    
    # Detects vagrant-triggers plugin
    if Vagrant.has_plugin?('vagrant-triggers')
      puts 'INFO:  Vagrant-triggers plugin detected.'
    else
      Preamble.Preamble.confirmAndInstall("triggers")
    end
    
    # Detects vagrant-cachier plugin
    if Vagrant.has_plugin?('vagrant-cachier')
      puts 'INFO:  Vagrant-cachier plugin detected. Optimizing caches.'
      # Configure cached packages to be shared between instances of the same base box.
      # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
      config.cache.scope = :box
    else
      Preamble.Preamble.confirmAndInstall("cachier")
    end
  
    # Detects vagrant-omnibus plugin
    if Vagrant.has_plugin?('vagrant-omnibus')
      puts 'INFO:  Vagrant-omnibus plugin detected.'
      # config.omnibus.install_url = 'http://acme.com/install.sh'
      config.omnibus.chef_version = "11.16.4" # :latest
    else
      Preamble.confirmAndInstall("omnibus")
    end
    # Detects vagrant-vbguest plugin
    if Vagrant.has_plugin?('vagrant-vbguest')
      puts 'INFO:  Vagrant-vbguest plugin detected.'
      #config.vbguest.auto_update = false
      # do NOT download the iso file from a webserver
      config.vbguest.no_remote = true
      # Whether to check the correct additions version only.
      config.vbguest.no_install = true
    else
      Preamble.confirmAndInstall("vbguest")
    end
    
    # Detects vagrant-butcher plugin
    if Vagrant.has_plugin?('vagrant-butcher')
      puts 'INFO:  Vagrant-butcher plugin detected.'
      config.butcher.enabled = true # Default
      config.butcher.verify_ssl = false
      #config.butcher.client_key = "local-workstation.pem"
      #config.butcher.client_name = "root"
    else
      Preamble.confirmAndInstall("butcher")
    end
    
    if @installedPlugin
      warn "Plugins are installed. Please start Vagrant again!"
      exit
    end
  end
  
  def self.confirmAndInstall(plugin_name)
    warn "Vagrant-#{plugin_name} plugin was not detected and will be installed."
    confirm = nil
    until ["Y", "y", "N", "n", ""].include?(confirm)
      confirm = (Preamble.prompt "Do you really want to install 'vagrant-#{plugin_name}'? (y/N) ").chomp
    end
    if confirm.upcase != "Y"
      puts "Could not install vagrant-#{plugin_name} plugin. Exiting System."
      exit 0
    else
      success = system("vagrant plugin install vagrant-#{plugin_name}")
      #@installedPlugin = @installedPlugin || success
    end
  end
  def self.prompt(message)
    puts message
    return $stdin.gets
  end
end