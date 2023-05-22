# @summary Define for package types
#   For a full description of the exec type check: https://www.puppet.com/docs/puppet/7/types/package.html
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-ensure for more information.
#
# @param adminfile
#   Value passed to adminfile attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-adminfile for more information.
#
# @param allowcdrom
#   Value passed to allowcdrom attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-allowcdrom for more information.
#
# @param configfiles
#   Value passed to configfiles attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-configfiles for more information.
#
# @param enable_only
#   Value passed to provider attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-enable_only for more information.
#
# @param install_options
#   Value passed to install_options attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-install_options for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-provider for more information.
#
# @param responsefile
#   Value passed to responsefile attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-responsefile for more information.
#
# @param source
#   Value passed to source attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-source for more information.
#
# @param uninstall_options
#   Value passed to uninstall_options attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/package.html#package-attribute-uninstall_options for more information.
#
define types::package (
  Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest'] $ensure            = 'present',
  Optional[Stdlib::Absolutepath]                                         $adminfile         = undef,
  Optional[String[1]]                                                    $allowcdrom        = undef,
  Optional[Enum['keep', 'replace']]                                      $configfiles       = undef,
  Optional[Boolean]                                                      $enable_only       = undef,
  Optional[String[1]]                                                    $install_options   = undef,
  Optional[String[1]]                                                    $provider          = undef,
  Optional[Stdlib::Absolutepath]                                         $responsefile      = undef,
  Optional[String[1]]                                                    $source            = undef,
  Optional[String[1]]                                                    $uninstall_options = undef,
) {
  package { $name:
    ensure            => $ensure,
    adminfile         => $adminfile,
    configfiles       => $configfiles,
    enable_only       => $enable_only,
    install_options   => $install_options,
    provider          => $provider,
    responsefile      => $responsefile,
    source            => $source,
    uninstall_options => $uninstall_options,
  }
}
