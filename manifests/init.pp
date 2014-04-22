# == Class: types
#
# Module to manage types
#
class types (
  $crons              = undef,
  $files              = undef,
  $mounts             = undef,
  $crons_hiera_merge  = false,
  $files_hiera_merge  = false,
  $mounts_hiera_merge = false,
) {

  if type($crons_hiera_merge) == 'string' {
    $crons_hiera_merge_real = str2bool($crons_hiera_merge)
  } else {
    $crons_hiera_merge_real = $crons_hiera_merge
  }
  validate_bool($crons_hiera_merge_real)

  if type($files_hiera_merge) == 'string' {
    $files_hiera_merge_real = str2bool($files_hiera_merge)
  } else {
    $files_hiera_merge_real = $files_hiera_merge
  }
  validate_bool($files_hiera_merge_real)

  if type($mounts_hiera_merge) == 'string' {
    $mounts_hiera_merge_real = str2bool($mounts_hiera_merge)
  } else {
    $mounts_hiera_merge_real = $mounts_hiera_merge
  }
  validate_bool($mounts_hiera_merge_real)

  if $crons != undef {
    if $crons_hiera_merge_real == true {
      $crons_real = hiera_hash('types::crons')
    } else {
      $crons_real = $crons
    }
    validate_hash($crons_real)
    create_resources('types::cron',$crons_real)
  }

  if $files != undef {
    if $files_hiera_merge_real == true {
      $files_real = hiera_hash('types::files')
    } else {
      $files_real = $files
    }
    validate_hash($files_real)
    create_resources('types::file',$files_real)
  }

  if $mounts != undef {
    if $mounts_hiera_merge_real == true {
      $mounts_real = hiera_hash('types::mounts')
    } else {
      $mounts_real = $mounts
    }
    validate_hash($mounts_real)
    create_resources('types::mount',$mounts_real)
  }
}
