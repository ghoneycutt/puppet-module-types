# == Define: types::selboolean
#
define types::selboolean (
  $value,
  $persistent = false,
  $provider   = undef,
) {

  validate_re($value, '^(on)|(off)$',
    "types::selboolean::${name}::value is invalid should be 'on' or 'off'.")
  validate_bool($persistent)
  if $provider != undef {
    validate_string($provider)
  }

  selboolean { $name:
    value      => $value,
    persistent => $persistent,
    provider   => $provider,
  }
}
