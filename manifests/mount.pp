# == Define: types::mount
#
define types::mount (
  $device,
  $fstype,
  $target,
  $ensure      = present,
  $atboot      = true,
  $blockdevice = undef,
  $dump        = undef,
  $options     = $options,
  $pass        = $pass,
  $provider    = $provider,
  $remounts    = $remounts,
) {

  # validate params
  validate_re($ensure, '^(present)|(unmounted)|(absent)|(mounted)$', "types::mount::${name}::ensure is invalid and does not match the regex.")
  validate_absolute_path($target)

  # ensure target exists
  include common
  common::mkdir_p { $target: }

  mount { "types_mount_${name}":
    ensure      => $ensure,
    atboot      => $atboot,
    blockdevice => $blockdevice,
    device      => $device,
    dump        => $dump,
    fstype      => $fstype,
    options     => $options,
    pass        => $pass,
    provider    => $provider,
    remounts    => $remounts,
    target      => $target,
    require     => Mkdir_p[$target],
  }
}
