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
# @param ensure_packages
#   Array of packages to install with `ensure_packages`.
#
class types (
  Hash  $crons           = {},
  Hash  $execs           = {},
  Hash  $file_lines      = {},
  Hash  $files           = {},
  Hash  $mounts          = {},
  Hash  $packages        = {},
  Hash  $selbooleans     = {},
  Hash  $services        = {},
  Array $ensure_packages = [],
) {
  create_resources('types::cron',$crons)
  create_resources('types::exec',$execs)
  create_resources('types::file_line',$file_lines)
  create_resources('types::file',$files)
  create_resources('types::mount',$mounts)
  create_resources('types::package',$packages)
  create_resources('types::selboolean',$selbooleans)
  create_resources('types::service',$services)
  ensure_packages($ensure_packages)
}
