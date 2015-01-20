require 'librarian/puppet'
require 'librarian/action'
require "librarian/puppet/action/install"

module VagrantPlugins
  module LibrarianPuppet
    module Action
      class Install
        def initialize(app, env)
          @app = app
          @env = env
          # Config#finalize! SHOULD be called automatically
          env[:machine].config.librarian_puppet.finalize!
        end

        def call(env)
          config = env[:machine].config.librarian_puppet
          if provisioned?
            # NB: Librarian::Puppet::Environment calls `which puppet` so we
            # need to make sure VAGRANT_HOME/gems/bin has been added to the
            # path.
            original_path = ENV['PATH']
            bin_path = env[:gems_path].join('bin')
            ENV['PATH'] = "#{bin_path}#{::File::PATH_SEPARATOR}#{ENV['PATH']}"

            puppetfile_dirs = config.puppetfile_dir.kind_of?(Array) ? config.puppetfile_dir : [config.puppetfile_dir]

            puppetfile_dirs.each do |puppetfile_dir|
              provision(puppetfile_dir, env, config)
            end

            # Restore the original path
            ENV['PATH'] = original_path
          end
          @app.call(env)
        end

        def provision(puppetfile_dir, env, config)
          if File.exist? File.join(env[:root_path], config.puppetfile_path(puppetfile_dir))

            env[:ui].info "Installing Puppet modules in \"#{puppetfile_dir}\" with Librarian-Puppet..."

            # Determine if we need to persist placeholder file
            placeholder_file = File.join(
              env[:root_path],
              puppetfile_dir,
              'modules',
              config.placeholder_filename
            )
            if File.exist? placeholder_file
              placeholder_contents = File.read(placeholder_file)
            else
              placeholder_contents = nil
            end

            environment = Librarian::Puppet::Environment.new({
              :project_path => File.join(env[:root_path], puppetfile_dir)
            })
            environment.config_db.local['destructive']  = config.destructive.to_s
            environment.config_db.local['use-v1-api']   = config.use_v1_api

            Librarian::Action::Ensure.new(environment).run
            Librarian::Action::Resolve.new(environment, config.resolve_options).run
            Librarian::Puppet::Action::Install.new(environment).run

            # Persist placeholder if necessary
            if placeholder_contents != nil
              File.open(placeholder_file, 'w') { |file|
                file.write(placeholder_contents)
              }
            end
          end
        end

        def provisioned?
          @env[:provision_enabled].nil? ? true : @env[:provision_enabled]
        end

      end
    end
  end
end
