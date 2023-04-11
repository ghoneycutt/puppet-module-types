# @summary Module to manage types
#   Puppet module to manage default types through hashes in Hiera with the
#   create_resources() function. This module adds validation and helper functions,
#   such as ensuring directories. Without specifying any hashes, this module will
#   take no action.
#
# @param crons
#   Hash of resource type `cron`.
#
# @param execs
#   Hash of resource type `exec`.
#
# @param file_lines
#   Hash of resource type `file_line`.
#
# @param files
#   Hash of resource type `file`.
#
# @param mounts
#   Hash of resource type `mount`.
#
# @param packages
#   Hash of resource type `package`.
#
# @param selbooleans
#   Hash of resource type `selboolean`.
#
# @param services
#   Hash of resource type `service`.
#
# @param crons_hiera_merge
#   Boolean to control merges of all found instances of types::crons in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param execs_hiera_merge
#   Boolean to control merges of all found instances of types::execs in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param file_lines_hiera_merge
#   Boolean to control merges of all found instances of types::file_lines in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param files_hiera_merge
#   Boolean to control merges of all found instances of types::files in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param mounts_hiera_merge
#   Boolean to control merges of all found instances of types::mounts in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param packages_hiera_merge
#   Boolean to control merges of all found instances of types::packages in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param selbooleans_hiera_merge
#   Boolean to control merges of all found instances of types::selbooleans in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
# @param services_hiera_merge
#   Boolean to control merges of all found instances of types::services in Hiera.
#   This is useful for specifying cron resources at different levels of the hierarchy and having them all included in the catalog.
#
class types (
  Hash    $crons                   = {},
  Hash    $execs                   = {},
  Hash    $file_lines              = {},
  Hash    $files                   = {},
  Hash    $mounts                  = {},
  Hash    $packages                = {},
  Hash    $selbooleans             = {},
  Hash    $services                = {},
  Boolean $crons_hiera_merge       = false,
  Boolean $execs_hiera_merge       = false,
  Boolean $file_lines_hiera_merge  = true,
  Boolean $files_hiera_merge       = false,
  Boolean $mounts_hiera_merge      = false,
  Boolean $packages_hiera_merge    = true,
  Boolean $selbooleans_hiera_merge = true,
  Boolean $services_hiera_merge    = true,
) {
  if $crons != {} {
    if $crons_hiera_merge == true {
      $crons_real = hiera_hash('types::crons')
    } else {
      $crons_real = $crons
    }
    validate_hash($crons_real)
    create_resources('types::cron',$crons_real)
  }

  if $execs != {} {
    if $execs_hiera_merge == true {
      $execs_real = hiera_hash('types::execs')
    } else {
      $execs_real = $execs
    }
    validate_hash($execs_real)
    create_resources('types::exec',$execs_real)
  }

  if $file_lines != {} {
    if $file_lines_hiera_merge == true {
      $file_lines_real = hiera_hash('types::file_lines')
    } else {
      $file_lines_real = $file_lines
    }
    validate_hash($file_lines_real)
    create_resources('types::file_line',$file_lines_real)
  }

  if $files != {} {
    if $files_hiera_merge == true {
      $files_real = hiera_hash('types::files')
    } else {
      $files_real = $files
    }
    validate_hash($files_real)
    create_resources('types::file',$files_real)
  }

  if $mounts != {} {
    if $mounts_hiera_merge == true {
      $mounts_real = hiera_hash('types::mounts')
    } else {
      $mounts_real = $mounts
    }
    validate_hash($mounts_real)
    create_resources('types::mount',$mounts_real)
  }

  if $packages != {} {
    if $packages_hiera_merge == true {
      $packages_real = hiera_hash('types::packages')
    } else {
      $packages_real = $packages
    }
    validate_hash($packages_real)
    create_resources('types::package',$packages_real)
  }

  if $selbooleans != {} {
    if $selbooleans_hiera_merge == true {
      $selbooleans_real = hiera_hash('types::selboolean')
    } else {
      $selbooleans_real = $selbooleans
    }
    validate_hash($selbooleans_real)
    create_resources('types::selboolean',$selbooleans_real)
  }

  if $services != {} {
    if $services_hiera_merge == true {
      $services_real = hiera_hash('types::services')
    } else {
      $services_real = $services
    }
    validate_hash($services_real)
    create_resources('types::service',$services_real)
  }
}
