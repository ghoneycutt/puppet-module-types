# == Define: types::mailalias
#
define types::mailalias (
  $ensure    = 'present',
  $provider  = 'aliases',
  $recipient = 'MANDATORY',
  $target    = '/etc/aliases',
) {

  validate_re($ensure, [ '^present$', '^absent$' ],
    "types::mailalias::${name}::ensure is invalid and does not match the regex.")

  validate_re($provider, [ '^aliases$' ],
    "types::mailalias::${name}::provider is invalid and does not match the regex.")

  if $recipient == 'MANDATORY' or empty($recipient) {
    fail("types::mailalias::${name}::recipient is MANDATORY.")
  }
  validate_string($recipient)

  validate_absolute_path($target)

  mailalias { $name:
    ensure    => $ensure,
    name      => $name,
    provider  => $provider,
    recipient => $recipient,
    target    => $target,
    notify    => Exec["${name}-generate_new_aliases_db"],
  }

  exec { "${name}-generate_new_aliases_db":
    path        => [ '/bin', '/usr/bin', '/sbin', '/usr/sbin' ],
    command     => 'newaliases',
    refreshonly => true,
  }
}
