# vagrant-librarian-puppet

A [Vagrant](https://www.vagrantup.com/) plugin to install
[Puppet](https://docs.puppetlabs.com/#puppetpuppet) modules using
[Librarian-Puppet](https://github.com/voxpupuli/librarian-puppet).

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

Like the `puppet.module_path`, `librarian_puppet.puppetfile_dir` supports both,
a simple String or an Array of Strings. Librarian Puppet will look for Puppetfiles
in each Directory and manage each modules directory.


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
  config.librarian_puppet.use_v1_api  = '1' # Check https://github.com/voxpupuli/librarian-puppet#how-to-use
  config.librarian_puppet.destructive = false # Check https://github.com/voxpupuli/librarian-puppet#how-to-use

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"

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
