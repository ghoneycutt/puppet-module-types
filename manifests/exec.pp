# == Define: types::exec
#
define types::exec (
  $command,
  $creates     = undef,
  $cwd         = undef,
  $environment = undef,
  $group       = undef,
  $logoutput   = undef,
  $onlyif      = undef,
  $path        = undef,
  $provider    = undef,
  $refresh     = undef,
  $refreshonly = undef,
  $returns     = undef,
  $timeout     = undef,
  $tries       = undef,
  $try_sleep   = undef,
  $unless      = undef,
  $user        = undef,
) {

  # validate params
  if $creates != undef {
    validate_absolute_path($creates)
  }
  if $cwd != undef {
    validate_absolute_path($cwd)
  }
  if $provider != undef {
    validate_re($provider, '^(posix|shell|windows)$',
      "types::exec::${name}::provider is invalid and does not match the regex.")
  }

  exec { $name:
    command     => $command,
    creates     => $creates,
    cwd         => $cwd,
    environment => $environment,
    group       => $group,
    logoutput   => $logoutput,
    onlyif      => $onlyif,
    path        => $path,
    provider    => $provider,
    refresh     => $refresh,
    refreshonly => $refreshonly,
    returns     => $returns,
    timeout     => $timeout,
    tries       => $tries,
    try_sleep   => $try_sleep,
    unless      => $unless,
    user        => $user,
  }
}
