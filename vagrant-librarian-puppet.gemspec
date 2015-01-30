# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-librarian-puppet/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-librarian-puppet"
  spec.version       = VagrantPlugins::LibrarianPuppet::VERSION
  spec.authors       = ["Michael Hahn"]
  spec.email         = ["mwhahn@gmail.com"]
  spec.description   = %q{A Vagrant plugin to install Puppet modules using Librarian-Puppet.}
  spec.summary       = %q{A Vagrant plugin to install Puppet modules using Librarian-Puppet.}
  spec.homepage      = "https://github.com/mhahn/vagrant-librarian-puppet"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "librarian-puppet", "~> 2.0.1"
  # puppet_forge (all versions up to this date) have a dep on her ~> 0.6,
  # her >= 0.7.3 pulls in activemodel 4.2,
  # which pulls in i18n ~> 0.7,
  # which is incompatible with vagrant 1.7.2 due to a hard dep on i18n 0.6.11.
  #
  # it's a bit surprising that bundler can't resolve this itself...
  spec.add_runtime_dependency "her", "< 0.7.3"
  spec.add_runtime_dependency "puppet", "~> 3.4.3"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
