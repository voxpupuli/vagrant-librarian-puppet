require 'librarian/puppet'
require 'librarian/action'

module VagrantPlugins
  module LibrarianPuppet
    module Action
      class Install
        def initialize(app, env)
          @app = app
          @env = env
          # Config#finalize! SHOULD be called automatically
          env[:global_config].librarian_puppet.finalize!
        end

        def call(env)
          config = env[:global_config].librarian_puppet
          if
            provisioned? and
            File.exist? File.join(env[:root_path], config.puppetfile_path)

            env[:ui].info "Installing Puppet modules with Librarian-Puppet..."

            # NB: Librarian::Puppet::Environment calls `which puppet` so we
            # need to make sure VAGRANT_HOME/gems/bin has been added to the
            # path.
            original_path = ENV['PATH']
            bin_path = env[:gems_path].join('bin')
            ENV['PATH'] = "#{bin_path}#{::File::PATH_SEPARATOR}#{ENV['PATH']}"

            # Determine if we need to persist placeholder file
            placeholder_file = File.join(
              env[:root_path],
              config.puppetfile_dir,
              'modules',
              config.placeholder_filename
            )
            if File.exist? placeholder_file
              placeholder_contents = File.read(placeholder_file)
            else
              placeholder_contents = nil
            end

            environment = Librarian::Puppet::Environment.new({
              :project_path => File.join(env[:root_path], config.puppetfile_dir)
            })
            Librarian::Action::Ensure.new(environment).run
            Librarian::Action::Resolve.new(environment, config.resolve_options).run
            Librarian::Action::Install.new(environment).run

            # Restore the original path
            ENV['PATH'] = original_path

            # Persist placeholder if necessary
            if placeholder_contents != nil
              File.open(placeholder_file, 'w') { |file|
                file.write(placeholder_contents)
              }
            end

          end
          @app.call(env)
        end

        def provisioned?
          @env[:provision_enabled].nil? ? true : @env[:provision_enabled]
        end

      end
    end
  end
end
