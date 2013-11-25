# == Class: types
#
# Module to manage types
#
class types (
  $mounts = undef,
) {

  if $mounts != undef {
    validate_hash($mounts)
    create_resources('types::mount',$mounts)
  }
}
