# == Class: types
#
# Module to manage types
#
class types (
  $mounts = undef,
) {

  if $mounts != undef {
    if type($mounts) != 'hash' {
      fail('types::mounts must be a hash.')
    } else {
      create_resources('types::mount',$mounts)
    }
  }
}
