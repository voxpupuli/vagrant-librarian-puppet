# vagrant-librarian-puppet

A [Vagrant](http://www.vagrantup.com/) plugin to install
[Puppet](http://docs.puppetlabs.com/#puppetpuppet) modules using
[Librarian-Puppet](https://github.com/rodjek/librarian-puppet).

## Requirements

* Vagrant version 1.2.0 or greater.

## Installation

``` bash
vagrant plugin install vagrant-librarian-puppet
```

## Usage

Vagrant will automatically run Librarian-Puppet before any provisioning step, so
simply set up your Puppetfile as you normally would.

You may specify the subdirectory within which to run `librarian-puppet`
using the `librarian_puppet.puppetfile_dir` config key.  Please keep in mind
that you will need to explicitly set the `modules` path in the
`:puppet` provisioner and this path must exist before running vagrant commands.

**NOTE:** Since the puppet provisioner will fail if the path provided to
"puppet.modules" doesn't exist and librarian-puppet will destroy and recreate
the modules directory on each run, this plugin supports a placeholder file
within the modules directory that can be checked into version control and will
persist between provisions.

```ruby
Vagrant.configure("2") do |config|

  config.librarian_puppet.puppetfile_dir = "puppet"
  # placeholder_filename defaults to .PLACEHOLDER
  config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"

  config.vm.provision :puppet do |puppet|
    puppet.modules = "puppet/modules"

    ...

  end
end
```

## Development

``` bash
bundle
bundle exec vagrant up
```

## Acknowledgements

Thanks to @jimmycuadra and other contributors for their work on
[vagrant-librarian-chef](https://github.com/jimmycuadra/vagrant-librarian-chef).
This plugin made some slight changes to work with puppet, but largely just used
their code.
