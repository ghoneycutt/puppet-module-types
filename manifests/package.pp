# == Define: types::package
#
define types::package (
  $ensure            = 'present',
  $adminfile         = undef,
  $allowcdrom        = undef,
  $configfiles       = undef,
  $install_options   = undef,
  $provider          = undef,
  $responsefile      = undef,
  $source            = undef,
  $uninstall_options = undef,
) {

  validate_string($ensure)

  if $adminfile != undef {
    validate_absolute_path($adminfile)
  }

  if $configfiles != undef {
    validate_re($configfiles, '^(keep)|(replace)$',
      "types::package::${name}::configfiles is invalid and does not match the regex.")
  }

  if $responsefile != undef {
    validate_absolute_path($responsefile)
  }

  package { $name:
    ensure            => $ensure,
    adminfile         => $adminfile,
    configfiles       => $configfiles,
    install_options   => $install_options,
    provider          => $provider,
    responsefile      => $responsefile,
    source            => $source,
    uninstall_options => $uninstall_options,
  }
}
