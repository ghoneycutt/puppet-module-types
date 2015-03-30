# == Class: types
#
# Module to manage types
#
class types (
  $crons                  = undef,
  $file_lines             = undef,
  $files                  = undef,
  $mounts                 = undef,
  $packages               = undef,
  $services               = undef,
  $crons_hiera_merge      = false,
  $file_lines_hiera_merge = true,
  $files_hiera_merge      = false,
  $mounts_hiera_merge     = false,
  $packages_hiera_merge   = true,
  $services_hiera_merge   = true,
) {

  if is_string($crons_hiera_merge) {
    $crons_hiera_merge_real = str2bool($crons_hiera_merge)
  } else {
    $crons_hiera_merge_real = $crons_hiera_merge
  }
  validate_bool($crons_hiera_merge_real)

  if is_string($file_lines_hiera_merge) {
    $file_lines_hiera_merge_real = str2bool($file_lines_hiera_merge)
  } else {
    $file_lines_hiera_merge_real = $file_lines_hiera_merge
  }
  validate_bool($file_lines_hiera_merge_real)

  if is_string($files_hiera_merge) {
    $files_hiera_merge_real = str2bool($files_hiera_merge)
  } else {
    $files_hiera_merge_real = $files_hiera_merge
  }
  validate_bool($files_hiera_merge_real)

  if is_string($mounts_hiera_merge) {
    $mounts_hiera_merge_real = str2bool($mounts_hiera_merge)
  } else {
    $mounts_hiera_merge_real = $mounts_hiera_merge
  }
  validate_bool($mounts_hiera_merge_real)

  if is_string($packages_hiera_merge) {
    $packages_hiera_merge_real = str2bool($packages_hiera_merge)
  } else {
    $packages_hiera_merge_real = $packages_hiera_merge
  }
  validate_bool($packages_hiera_merge_real)

  if is_string($services_hiera_merge) {
    $services_hiera_merge_real = str2bool($services_hiera_merge)
  } else {
    $services_hiera_merge_real = $services_hiera_merge
  }
  validate_bool($services_hiera_merge_real)

  if $crons != undef {
    if $crons_hiera_merge_real == true {
      $crons_real = hiera_hash('types::crons')
    } else {
      $crons_real = $crons
    }
    validate_hash($crons_real)
    create_resources('types::cron',$crons_real)
  }

  if $file_lines != undef {
    if $file_lines_hiera_merge_real == true {
      $file_lines_real = hiera_hash('types::file_lines')
    } else {
      $file_lines_real = $file_lines
    }
    validate_hash($file_lines_real)
    create_resources('types::file_line',$file_lines_real)
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

  if $packages != undef {
    if $packages_hiera_merge_real == true {
      $packages_real = hiera_hash('types::packages')
    } else {
      $packages_real = $packages
    }
    validate_hash($packages_real)
    create_resources('types::package',$packages_real)
  }

  if $services != undef {
    if $services_hiera_merge_real == true {
      $services_real = hiera_hash('types::services')
    } else {
      $services_real = $services
    }
    validate_hash($services_real)
    create_resources('types::service',$services_real)
  }
}
