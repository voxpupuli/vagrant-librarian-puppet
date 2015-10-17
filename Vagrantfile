#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # box needs to provide puppet >= 4
  config.vm.box = 'puppetlabs/ubuntu-12.04-64-puppet'

  config.vm.define "default" do |default|
    default.librarian_puppet.puppetfile_dir = 'puppet'
    default.librarian_puppet.placeholder_filename = ".gitkeep"
    default.librarian_puppet.resolve_options = { :force => true }
    default.librarian_puppet.destructive = false

    default.vm.provision :puppet do |puppet|
      puppet.environment_path = "environments"
      puppet.environment = "default"
      puppet.module_path = 'puppet/modules'
    end
  end

  config.vm.define "multidir" do |multidir|
    multidir.librarian_puppet.puppetfile_dir = ['puppet', 'puppet_custom']
    multidir.librarian_puppet.placeholder_filename = ".gitkeep"
    multidir.librarian_puppet.resolve_options = { :force => true }
    multidir.librarian_puppet.destructive = false

    multidir.vm.provision :puppet do |puppet|
      puppet.environment_path = "environments"
      puppet.environment = "multidir"
      puppet.module_path = ['puppet_custom/modules', 'puppet/modules']
    end
  end
end
