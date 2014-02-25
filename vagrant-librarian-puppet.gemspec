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

  spec.add_runtime_dependency "librarian-puppet"
  spec.add_runtime_dependency "librarian"
  spec.add_runtime_dependency "puppet"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
