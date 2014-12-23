# VagrantPlugins::Chef::Plugin.provisioner[:chef_client]
# module VagrantPlugins
#   module Chef
#     module Provisioner
#       class Base
#         def chown_provisioning_folder
#           paths = [@config.provisioning_path,
#                    @config.file_backup_path,
#                    @config.file_cache_path]
#
#           @machine.communicate.tap do |comm|
#             paths.each do |path|
#               comm.sudo("test -h #{path} || mkdir -p #{path}")
#               comm.sudo("chown -h #{@machine.ssh_info[:username]} #{path}")
#             end
#           end
#         end
#       end
#     end
#   end
# end

# Fixes https://github.com/fgrehm/vagrant-cachier/issues/133
module VagrantPlugins
  module Cachier
    module Cap
      module Linux
        module ChefFileCachePath
          def self.chef_provisioner?(machine)
            provisioners = machine.config.vm.provisioners
            chef_provisioners = [:chef_solo, :chef_client]
            compat_provisioners = provisioners.keep_if { |p| chef_provisioners.include? p.name || p.type }
            if compat_provisioners.size > 1
              raise "One machine is using multiple chef provisioners, which is unsupported."
            end

            using_chef = compat_provisioners.empty? ? false : true
            using_chef
          end
          def self.chef_file_cache_path(machine)
            chef_file_cache_path = nil
            chef_file_cache_path = '/var/chef/cache' if chef_provisioner?(machine)

            return chef_file_cache_path
          end
        end
      end
    end
  end
end

VagrantPlugins::Cachier::Plugin.guest_capability 'linux', 'chef_file_cache_path' do
  VagrantPlugins::Cachier::Cap::Linux::ChefFileCachePath
end
