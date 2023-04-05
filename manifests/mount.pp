# @summary Define for mount types
#   For a full description of the mount type check: https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md
#
# @param device
#   Value passed to device attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#device for more information.
#
# @param fstype
#   Value passed to fstype attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#fstype for more information.
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#ensure for more information.
#
# @param atboot
#   Value passed to atboot attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#atboot for more information.
#
# @param blockdevice
#   Value passed to blockdevice attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#blockdevice for more information.
#
# @param dump
#   Value passed to dump attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#dump for more information.
#
# @param options
#   Value passed to options attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#options for more information.
#
# @param pass
#   Value passed to pass attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#pass for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#provider for more information.
#
# @param remounts
#   Value passed to remounts attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#remounts for more information.
#
# @param target
#   Value passed to target attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-mount_core/blob/main/REFERENCE.md#target for more information.
#
define types::mount (
  String[1]                                                    $device,
  String[1]                                                    $fstype,
  Enum['defined', 'present', 'unmounted', 'absent', 'mounted'] $ensure      = 'mounted',
  Boolean                                                      $atboot      = true,
  Optional[String[1]]                                          $blockdevice = undef,
  Optional[String[1]]                                          $dump        = undef,
  Optional[String[1]]                                          $options     = undef,
  Optional[String[1]]                                          $pass        = undef,
  Optional[String[1]]                                          $provider    = undef,
  Optional[Boolean]                                            $remounts    = undef,
  Optional[String[1]]                                          $target      = undef,
) {
  if $ensure != 'absent' {
    # ensure target exists
    include common
    common::mkdir_p { $name: }
  }

  # Solaris cannot handle 'defaults' as a mount option. A common use case would
  # be to have NFS exports specified in Hiera for multiple systems and if the
  # system is Solaris, it would throw an error.
  if $options == 'defaults' and $facts['os']['family'] == 'Solaris' {
    $options_real = '-'
  } else {
    $options_real = $options
  }

  mount { $name:
    ensure      => $ensure,
    name        => $name,
    atboot      => $atboot,
    blockdevice => $blockdevice,
    device      => $device,
    dump        => $dump,
    fstype      => $fstype,
    options     => $options_real,
    pass        => $pass,
    provider    => $provider,
    remounts    => $remounts,
    target      => $target,
  }

  if $ensure != 'absent' {
    Common::Mkdir_p[$name] -> Mount[$name]
  }
}
