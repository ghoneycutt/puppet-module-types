# == Class: types
#
# Module to manage types
#
class types (
  $cron   = undef,
  $mounts = undef,
) {

  if $cron != undef {
    validate_hash($cron)
    create_resources('types::cron',$cron)
  }

  if $mounts != undef {
    validate_hash($mounts)
    create_resources('types::mount',$mounts)
  }
}
