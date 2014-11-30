# Monkeypatch "Docker provider download 'not implemented yet'" 
# ( https://github.com/cassianoleal/vagrant-butcher/issues/55#issuecomment-64412748 )
# Open Issue: https://github.com/mitchellh/vagrant/issues/4864
module Vagrant
  module Butcher
    module Helpers
      module KeyFiles
        def grab_key_from_guest(env)
          create_cache_dir(env)

          machine(env).communicate.execute("cat #{guest_key_path(env)}", sudo: true) do |type,data|
            File.open("#{cache_dir(env)}/#{key_filename(env)}", "w") { |f| f << data } if type == :stdout
          end

          env[:ui].info "Saved client key to #{cache_dir(env)}/#{key_filename(env)}"
        end
      end
    end
  end
end