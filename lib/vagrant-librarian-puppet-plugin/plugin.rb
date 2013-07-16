begin
  require "vagrant"
rescue LoadError
  abort "vagrant-librarian-puppet-plugin must be loaded in a Vagrant environment."
end

require "vagrant-librarian-puppet-plugin/action/librarian_puppet"


module VagrantPlugins
  module LibrarianPuppet
    class Plugin < Vagrant.plugin("2")
      name "vagrant-librarian-puppet-plugin"
      description <<-DESC
A Vagrant plugin to install Puppet modules using Librarian-Puppet.
DESC
      action_hook "librarian_puppet" do |hook|
        # XXX see if we can only hook so long as a command option isn't passed
        hook.before Vagrant::Action::Builtin::Provision, Action::Install
      end

      config "librarian_puppet" do
        require_relative "config"
        Config
      end
    end
  end
end
