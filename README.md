# puppet-module-types
===

Puppet module to manage default types through Hiera. Lofty goal of covering all
of the default types that ship with Puppet.

# Hiera

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
    atboot: yes
    remounts: true
    blockdevice: '-'
</pre>
