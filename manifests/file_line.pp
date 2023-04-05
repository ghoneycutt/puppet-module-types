# == Define: types::file_line
#
define types::file_line (
  $path,
  $line,
  $match  = undef,
  $ensure = 'present',
) {
  validate_re($ensure, '^(present)|(absent)$', "types::file_line::${name}::ensure is invalid and does not match the regex.")
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
