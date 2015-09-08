# == Define: types::file_line
#
define types::file_line (
  $ensure = 'present',
  $path,
  $line,
  $match  = undef,
) {

  validate_re($ensure, '^(present)|(absent)$',
    "types::file_line::${name}::ensure is invalid and does not match the regex.")
  validate_absolute_path($path)
  validate_string($line)

  if $match {
    validate_string($match)
  }

  file_line { $name:
    ensure => $ensure,
    path   => $path,
    line   => $line,
    match  => $match,
  }
}
