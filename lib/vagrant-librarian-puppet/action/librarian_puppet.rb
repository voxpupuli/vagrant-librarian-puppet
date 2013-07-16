require 'librarian/puppet'
require 'librarian/action'

module VagrantPlugins
  module LibrarianPuppet
    module Action
      class Install
        def initialize(app, env)
          @app = app
          # Config#finalize! SHOULD be called automatically
          env[:global_config].librarian_puppet.finalize!
        end

        def call(env)
          config = env[:global_config].librarian_puppet
          # look for a Puppetfile in the configured puppetfile_dir
          if FileTest.exist? File.join(env[:root_path], config.puppetfile_path)
            env[:ui].info "Installing Puppet modules with Librarian-Puppet..."
            environment = Librarian::Puppet::Environment.new({
              :project_path => File.join(env[:root_path], config.librarian_dir)
            })
            Librarian::Action::Ensure.new(environment).run
            Librarian::Action::Resolve.new(environment).run
            Librarian::Action::Install.new(environment).run
          end
          @app.call(env)
        end
      end
    end
  end
end
