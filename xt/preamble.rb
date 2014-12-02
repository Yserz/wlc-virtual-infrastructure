require 'vagrant.rb'


class Preamble
  @installedPlugin
  attr_accessor :is_windows
  @is_windows
  
  def initialize(config, version)
    Vagrant.require_version version
  
    # Detects Windows ;P
    @is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    @installedPlugin = false
    
    
    # Detects vagrant-triggers plugin
    if !Vagrant.has_plugin?('vagrant-triggers')
      Preamble.Preamble.confirmAndInstall("triggers")
    end
    
    # Detects vagrant-cachier plugin
    if !Vagrant.has_plugin?('vagrant-cachier')
      Preamble.Preamble.confirmAndInstall("cachier")
    end
  
    # Detects vagrant-omnibus plugin
    if !Vagrant.has_plugin?('vagrant-omnibus')
      Preamble.confirmAndInstall("omnibus")
    end
    # Detects vagrant-vbguest plugin
    if !Vagrant.has_plugin?('vagrant-vbguest')
      Preamble.confirmAndInstall("vbguest")
    end
    
    # Detects vagrant-butcher plugin
    if !Vagrant.has_plugin?('vagrant-butcher')
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