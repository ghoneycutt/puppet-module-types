# == Class: types
#
# Module to manage types
#
class types (
  $mounts          = undef,
  $use_hiera_array = true,
) {

  if $mounts != undef {
    validate_hash($mounts)

    if $use_hiera_array == true {
      $mounts_real = hiera_array($mounts)
    } else {
      $mounts_real = $mounts
    }

    create_resources('types::mount',$mounts_real)
  }
}
