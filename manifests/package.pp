# == Define: types::package
#
define types::package (
  $ensure            = 'present',
  $adminfile         = undef,
  $allow_virtual     = undef,
  $allowcdrom        = undef,
  $configfiles       = undef,
  $install_options   = undef,
#  $package_settings  = undef,
  $provider          = undef,
  $responsefile      = undef,
  $source            = undef,
  $uninstall_options = undef,
) {

  # validate params
  validate_re($ensure, '^(present)|(installed)|(absent)|(purged)|(held)|(latest)$',
    "types::package::${name}::ensure is invalid and does not match the regex.")
  if $adminfile != undef {
    validate_absolute_path($adminfile)
  }
#  if $allow_virtual != undef {
#    validate_re($allow_virtual, '^(true)|(false)|(yes)|(no)$',
#      "types::package::${name}::allow_virtual is invalid and does not match the regex.")
#  }
#  if $allowcdrom != undef {
#    validate_re($allowcdrom, '^(true)|(false)$',
#      "types::package::${name}::allowcdrom is invalid and does not match the regex.")
#  }
#  if $configfiles != undef {
#    validate_re($configfiles, '^(keep)|(replace)$',
#      "types::package::${name}::configfiles is invalid and does not match the regex.")
#  }
  if $responsefile != undef {
    validate_absolute_path($responsefile)
  }

  package { $name:
    ensure            => $ensure,
    adminfile         => $adminfile,
#    allow_virtual     => $allow_virtual,
    allowcdrom        => $allowcdrom,
    configfiles       => $configfiles,
    install_options   => $install_options,
#    package_settings  => $package_settings,
    provider          => $provider,
    responsefile      => $responsefile,
    source            => $source,
    uninstall_options => $uninstall_options,
  }
}
