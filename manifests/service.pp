# @summary Define for service types
#   For a full description of the exec type check: https://www.puppet.com/docs/puppet/7/types/service.html
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-ensure for more information.
#
# @param binary
#   Value passed to binary attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-binary for more information.
#
# @param control
#   Value passed to control attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-control for more information.
#
# @param enable
#   Value passed to enable attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-enable for more information.
#
# @param hasrestart
#   Value passed to hasrestart attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-hasrestart for more information.
#
# @param hasstatus
#   Value passed to hasstatus attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-hasstatus for more information.
#
# @param manifest
#   Value passed to manifest attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-manifest for more information.
#
# @param path
#   Value passed to path attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-path for more information.
#
# @param pattern
#   Value passed to pattern attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-pattern for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-provider for more information.
#
# @param restart
#   Value passed to restart attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-restart for more information.
#
# @param start
#   Value passed to start attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-start for more information.
#
# @param status
#   Value passed to status attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-status for more information.
#
# @param stop
#   Value passed to stop attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/service.html#service-attribute-stop for more information.
#
define types::service (
  Variant[Boolean, Enum['stopped', 'running', 'false', 'true']] $ensure      = 'running',
  Optional[String[1]]                                           $binary      = undef,
  Optional[String[1]]                                           $control     = undef,
  Variant[Boolean, Enum['true', 'false', 'manual']]             $enable      = true,
  Optional[Variant[Boolean, Enum['true', 'false']]]             $hasrestart  = undef,
  Optional[Variant[Boolean, Enum['true', 'false']]]             $hasstatus   = undef,
  Optional[String[1]]                                           $manifest    = undef,
  Optional[String[1]]                                           $path        = undef,
  Optional[String[1]]                                           $pattern     = undef,
  Optional[String[1]]                                           $provider    = undef,
  Optional[String[1]]                                           $restart     = undef,
  Optional[String[1]]                                           $start       = undef,
  Optional[String[1]]                                           $status      = undef,
  Optional[String[1]]                                           $stop        = undef,
) {
  service { $name:
    ensure     => $ensure,
    binary     => $binary,
    control    => $control,
    enable     => $enable,
    hasrestart => $hasrestart,
    hasstatus  => $hasstatus,
    manifest   => $manifest,
    path       => $path,
    pattern    => $pattern,
    provider   => $provider,
    restart    => $restart,
    start      => $start,
    status     => $status,
    stop       => $stop,
  }
}
