#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.define "default" do |default|
    default.librarian_puppet.puppetfile_dir = 'puppet'
    default.librarian_puppet.placeholder_filename = ".gitkeep"
    default.librarian_puppet.resolve_options = { :force => true }

    default.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file = 'init.pp'
      puppet.module_path = 'puppet/modules'
    end
  end

  config.vm.define "multidir" do |multidir|
    multidir.librarian_puppet.puppetfile_dir = ['puppet', 'puppet_custom']
    multidir.librarian_puppet.placeholder_filename = ".gitkeep"
    multidir.librarian_puppet.resolve_options = { :force => true }

    multidir.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.manifest_file = 'multidir.pp'
      puppet.module_path = ['puppet_custom/modules', 'puppet/modules']
    end
  end
end
