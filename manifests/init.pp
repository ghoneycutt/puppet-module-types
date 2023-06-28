# == Class: types
#
# Module to manage types
#
class types (
  $crons                   = undef,
  $execs                   = undef,
  $file_lines              = undef,
  $files                   = undef,
  $mounts                  = undef,
  $packages                = undef,
  $selbooleans             = undef,
  $services                = undef,
  $crons_hiera_merge       = false,
  $execs_hiera_merge       = false,
  $file_lines_hiera_merge  = true,
  $files_hiera_merge       = false,
  $mounts_hiera_merge      = false,
  $packages_hiera_merge    = true,
  $selbooleans_hiera_merge = true,
  $services_hiera_merge    = true,
) {

  if is_string($crons_hiera_merge) {
    $crons_hiera_merge_real = str2bool($crons_hiera_merge)
  } else {
    $crons_hiera_merge_real = $crons_hiera_merge
  }
  validate_bool($crons_hiera_merge_real)

  $execs_hiera_merge_bool = str2bool($execs_hiera_merge)

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

  if is_string($selbooleans_hiera_merge) {
    $selbooleans_hiera_merge_real = str2bool($selbooleans_hiera_merge)
  } else {
    $selbooleans_hiera_merge_real = $selbooleans_hiera_merge
  }
  validate_bool($selbooleans_hiera_merge_real)

  if is_string($services_hiera_merge) {
    $services_hiera_merge_real = str2bool($services_hiera_merge)
  } else {
    $services_hiera_merge_real = $services_hiera_merge
  }
  validate_bool($services_hiera_merge_real)

  if $crons != undef {
    if $crons_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $crons_real = hiera_hash('types::crons')
      } else {
        $crons_real = lookup('types::crons', Hash, 'deep', {})
      }
    } else {
      $crons_real = $crons
    }
    validate_hash($crons_real)
    create_resources('types::cron',$crons_real)
  }

  if $execs != undef {
    if $execs_hiera_merge_bool == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $execs_real = hiera_hash('types::execs')
      } else {
        $execs_real = lookup('types::execs', Hash, 'deep', {})
      }
    } else {
      $execs_real = $execs
    }
    validate_hash($execs_real)
    create_resources('types::exec',$execs_real)
  }

  if $file_lines != undef {
    if $file_lines_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $file_lines_real = hiera_hash('types::file_lines')
      } else {
        $file_lines_real = lookup('types::file_lines', Hash, 'deep', {})
      }
    } else {
      $file_lines_real = $file_lines
    }
    validate_hash($file_lines_real)
    create_resources('types::file_line',$file_lines_real)
  }

  if $files != undef {
    if $files_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $files_real = hiera_hash('types::files')
      } else {
        $files_real = lookup('types::files', Hash, 'deep', {})
      }
    } else {
      $files_real = $files
    }
    validate_hash($files_real)
    create_resources('types::file',$files_real)
  }

  if $mounts != undef {
    if $mounts_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $mounts_real = hiera_hash('types::mounts')
      } else {
        $mounts_real = lookup('types::mounts', Hash, 'deep', {})
      }
    } else {
      $mounts_real = $mounts
    }
    validate_hash($mounts_real)
    create_resources('types::mount',$mounts_real)
  }

  if $packages != undef {
    if $packages_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $packages_real = hiera_hash('types::packages')
      } else {
        $packages_real = lookup('types::packages', Hash, 'deep', {})
      }
    } else {
      $packages_real = $packages
    }
    validate_hash($packages_real)
    create_resources('types::package',$packages_real)
  }

  if $selbooleans != undef {
    if $selbooleans_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $selbooleans_real = hiera_hash('types::selboolean')
      } else {
        $selbooleans_real = lookup('types::selboolean', Hash, 'deep', {})
      }
    } else {
      $selbooleans_real = $selbooleans
    }
    validate_hash($selbooleans_real)
    create_resources('types::selboolean',$selbooleans_real)
  }

  if $services != undef {
    if $services_hiera_merge_real == true {
      if versioncmp($::puppetversion, '4.0.0') < 0 {
        $services_real = hiera_hash('types::services')
      } else {
        $services_real = lookup('types::services', Hash, 'deep', {})
      }
    } else {
      $services_real = $services
    }
    validate_hash($services_real)
    create_resources('types::service',$services_real)
  }
}
