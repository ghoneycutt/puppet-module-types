# puppet-module-types
===

Puppet module to manage default types through Hiera. Lofty goal of covering all
of the default types that ship with Puppet.

# Hiera

## mount
<pre>
types::mounts:
  dvd:
    device: /dev/dvd
    fstype: iso9660
    target: /mnt
  home:
    device: nfsserver:/export/home
    fstype: nfs
    target: /srv/nfs/home
    options: rw,rsize=8192,wsize=8192
</pre>
