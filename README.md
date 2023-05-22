# ghoneycutt/types
===

Puppet module to manage default types through hashes in Hiera with the
create_resources() function. This module adds validation and helper functions,
such as ensuring directories. Without specifying any hashes, this module will
take no action.

To use, simply `include ::types` and start specifying hashes of types in Hiera
as shown below.

You can add any of the supported options for the types in this module. Please
see the Puppet Labs
[Type Reference](http://docs.puppetlabs.com/references/stable/type.html) for
more information.

[![Build Status](https://api.travis-ci.org/ghoneycutt/puppet-module-types.png?branch=master)](https://travis-ci.org/ghoneycutt/puppet-module-types)

===

# Compatibility

This module supports Puppet v3 >= 3.2.0 (with and without the future
parser) and Puppet v4 with Ruby versions 1.8.7, 1.9.3,
2.0.0, 2.1.0 and 2.3.1. Please see .travis.yml for the full matrix.

===

# Dependencies

This module depends on [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) and [ghoneycutt/common](https://github.com/ghoneycutt/puppet-module-common).

===

# Parameters

crons
-----
Hash of resource type `cron`.

- *Default*: undef

execs
-----
Hash of resource type `exec`.

- *Default*: undef

file_lines
----------
Hash of resource type `file_line`.

- *Default*: undef

files
-----
Hash of resource type `file`.

- *Default*: undef

mounts
------
Hash of resource type `mount`.

- *Default*: undef

packages
--------
Hash of resource type `package`.

- *Default*: undef

selbooleans
-----------
Hash of resource type `selboolean`.

- *Default*: undef

services
--------
Hash of resource type `service`.

- *Default*: undef

===

# Defines

## `types::cron`
No helper resources are implemented. Simply passes attributes to a cron resource.

### Parameters required or with defaults

command
-------
The command to execute in the cron job.

- *Required*

ensure
------
State of cron resource. Valid values are 'present' and 'absent'.

- *Default*: 'present'

## `types::exec`
No helper resources are implemented. Simply passes attributes to a exec resource.

### Parameters required

command
-------
The command to execute.

- *Required*

creates
--------
A file to look for before running the command. The command will only run if the file doesn’t exist. Needs to be an absolute path.

- *Default*: undef

cwd
---
The directory from which to run the command. Needs to be an absolute path.

- *Default*: undef

provider
--------
Backend to use for the exec resource. Usually not needed to set. Possible values are 'posix', 'shell', and 'windows'.

- *Default*: undef

### Optional parameters. See [type exec reference](https://docs.puppet.com/puppet/latest/type.html#exec) for more information.

`environment`, `group`, `logoutput`, `onlyif`, `path`, `refresh`, `refreshonly`, `returns`, `timeout`,`tries`, `try_sleep`, `unless`, and `user`


## `types::file_line`
No helper resources are implemented. Simply passes attributes to a file_line resource.

### Parameters required or with defaults

path
----
Whether the file should exist, and if so what kind of file it should be. Possible values are 'present', 'absent', 'file', 'directory', and 'link'.

- *Required*

line
----
The user to whom the file should belong.

- *Required*

match
-----
A regex expressed as a string to replace existing lines.

- *Default*: undef

## `types::file`
No helper resources are implemented. Simply passes attributes to a file resource. The path attribute is not used, so the title must be the fully qualified path.

### Parameters required or with defaults

ensure
------
Whether the file should exist, and if so what kind of file it should be. Possible values are 'present', 'absent', 'file', 'directory', and 'link'.

- *Default*: 'present'

owner
-----
The user to whom the file should belong.

- *Default*: 'root'

group
-----
Which group should own the file.

- *Default*: 'root'

mode
----
Four digit mode.

- *Default*: '0644'

## `types::mount`

Besides ensuring the mount resource, will also ensure that the directory for
the mount exists.

If `options` parameter is passed and it is set to 'defaults' on osfamily
Solaris, it will use '-' as the mount option instead of 'defaults', as
'defaults' is not supported on Solaris.

### Parameters required or with defaults

device
------

- *Required*

fstype
------
Mount type.

- *Required*

ensure
------
State of mount.

- *Default*: mounted

atboot
------
Boolean to mount at boot.

- *Default*: true

### Optional parameters. See type reference for more information.

`blockdevice`, `dump`, `options`, `pass`, `provider`, `remounts`, `target`

## `types::package`

### Parameters required or with defaults

ensure
------
What state the package should be in.
 - *Default*: present

### Optional parameters. See type reference for more information.

`adminfile`, `allow_virtual`, `allowcdrom`, `configfiles`, `install_options`, `package_settings`, `provider`, `responsefile`, `source`, `uninstall_options`

## `types::service`
No helper resources are implemented. Simply passes attributes to a service resource.

### mostly used parameters

ensure
------
Whether a service should be running.

Valid values are 'stopped', 'false', 'running' and 'true'.

- *Default*: 'running'

enable
------
Whether a service should be enabled to start at boot.
Valid values are 'true', 'false', 'manual'.

- *Default*: 'true'

### Optional parameters. See [type reference](http://docs.puppetlabs.com/references/stable/type.html#service) for more information.

`binary`, `control`, `hasrestart`, `hasstatus`, `manifest`, `path`, `pattern`, `provider`, `restart`, `start`, `status`, `stop`

===

# Hiera

## cron
<pre>
types::crons:
  'clean puppet filebucket':
    command: '/usr/bin/find /var/lib/puppet/clientbucket/ -type f -mtime +30 -exec /bin/rm -fr {} \;'
    hour: 0
    minute: 0
  'purge old puppet dashboard reports':
    command: '/usr/bin/rake -f /usr/share/puppet-dashboard/Rakefile RAILS_ENV=production reports:prune upto=30 unit=day >> /var/log/puppet/dashboard_maintenance.log'
    hour: 0
    minute: 30
</pre>

## exec
<pre>
types::execs:
  'run script1 as user with an environment variable set and returns 242':
    command: '/opt/script1.sh'
    user: 'user'
    environment: 'interactive=false'
    returns: '242'
  'run script2 when no log file is present yet':
    command: '/opt/script2.sh'
    creates: '/opt/script.log'
</pre>

## file_line
<pre>
types::file_lines:
  'roots_path':
    path: '/root/.bash_profile'
    line: 'PATH=$PATH:/usr/pgsql-9.4/bin/:$HOME/bin'
    match: '^export PATH'
</pre>

## file
<pre>
types::files:
  '/tmp/foo':
    ensure: 'file'
  '/tmp/dir':
    ensure: 'directory'
  '/tmp/link':
    ensure: 'link'
    target: '/tmp/foo'
</pre>

## mount
<pre>
types::mounts:
  /mnt:
    device: /dev/dvd
    fstype: iso9660
    atboot: no
    remounts: true
  /srv/nfs/home:
    device: nfsserver:/export/home
    fstype: nfs
    options: rw,rsize=8192,wsize=8192
</pre>

## package
<pre>
types::packages:
  package1:
    ensure: present
  package2:
    ensure: absent
  package3:
    ensure: latest
</pre>

## selboolean
<pre>
types::selboolean:
  nfs_export_all_ro:
    value: on
    persistent: true
  nfs_export_all_rw:
    value: on
</pre>

## service
<pre>
types::services:
  iptables:
    ensure: 'false'
    enable: 'false'
  ip6tables:
    ensure: 'false'
    enable: 'false'
  tailored_firewalls:
    ensure: 'true'
    enable: 'true'
</pre>
