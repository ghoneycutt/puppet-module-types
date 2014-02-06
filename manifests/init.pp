# == Class: types
#
# Module to manage types
#
class types (
  $crons  = undef,
  $files  = undef,
  $mounts = undef,
) {

  if $crons != undef {
    validate_hash($crons)
    create_resources('types::cron',$crons)
  }

  if $files != undef {
    validate_hash($files)
    create_resources('types::file',$files)
  }

  if $mounts != undef {
    validate_hash($mounts)
    create_resources('types::mount',$mounts)
  }
}
