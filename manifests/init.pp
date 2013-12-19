# == Class: types
#
# Module to manage types
#
class types (
  $mounts = undef,
  $files   = undef,
) {

  if $mounts != undef {
    validate_hash($mounts)
    create_resources('types::mount',$mounts)
  }
  if $files != undef {
    validate_hash($files)
    create_resources('types::file',$files)
  }
}
