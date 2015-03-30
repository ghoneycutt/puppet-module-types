# == Define: types::file_line
#
define types::file_line (
  $path,
  $line,
  $match = undef,
) {

  validate_absolute_path($path)
  validate_string($line)

  if $match {
    validate_string($match)
  }

  file_line { $name:
    path  => $path,
    line  => $line,
    match => $match,
  }
}
