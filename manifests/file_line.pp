# @summary Define for file_line types
#   For a full description of the exec type check: https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/REFERENCE.md#file_line
#
# @param path
#   Value passed to path attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/REFERENCE.md#-file_line--path for more information.
#
# @param line
#   Value passed to line attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/REFERENCE.md#line for more information.
#
# @param match
#   Value passed to match attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/REFERENCE.md#-file_line--match for more information.
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-stdlib/blob/main/REFERENCE.md#ensure for more information.
#
define types::file_line (
  Stdlib::Absolutepath      $path,
  String[1]                 $line,
  Optional[String[1]]       $match  = undef,
  Enum['present', 'absent'] $ensure = 'present',
) {
  file_line { $name:
    ensure => $ensure,
    path   => $path,
    line   => $line,
    match  => $match,
  }
}
