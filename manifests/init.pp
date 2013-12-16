# == Class: types
#
# Module to manage types
#
class types (
  $mounts = undef,
  $file   = undef,
) {

  if $mounts != undef {
    validate_hash($mounts)
    create_resources('types::mount',$mounts)
  }
  if $file != undef {
    validate_hash($file)
    create_resources('types::file',$file)
  }
}
