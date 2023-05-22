# @summary Define for exec types
#   For a full description of the exec type check: https://www.puppet.com/docs/puppet/7/types/exec.html
#
# @param command
#   Value passed to command attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-command for more information.
#
# @param creates
#   Value passed to creates attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-creates for more information.
#
# @param cwd
#   Value passed to cwd attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-cwd for more information.
#
# @param environment
#   Value passed to environment attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-environment for more information.
#
# @param group
#   Value passed to group attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-group for more information.
#
# @param logoutput
#   Value passed to logoutput attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-logoutput for more information.
#
# @param onlyif
#   Value passed to onlyif attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-onlyif for more information.
#
# @param path
#   Value passed to path attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-path for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-provider for more information.
#
# @param refresh
#   Value passed to refresh attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-refresh for more information.
#
# @param refreshonly
#   Value passed to refreshonly attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-refreshonly for more information.
#
# @param returns
#   Value passed to returns attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-returns for more information.
#
# @param timeout
#   Value passed to timeout attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-timeout for more information.
#
# @param tries
#   Value passed to tries attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-tries for more information.
#
# @param try_sleep
#   Value passed to try_sleep attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-try_sleep for more information.
#
# @param unless
#   Value passed to unless attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-unless for more information.
#
# @param user
#   Value passed to user attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/exec.html#exec-attribute-user for more information.
#
define types::exec (
  String[1]                                      $command,
  Optional[Stdlib::Absolutepath]                 $creates     = undef,
  Optional[Stdlib::Absolutepath]                 $cwd         = undef,
  Optional[String[1]]                            $environment = undef,
  Optional[String[1]]                            $group       = undef,
  Optional[Variant[Boolean, Enum['on_failure']]] $logoutput   = undef,
  Optional[String[1]]                            $onlyif      = undef,
  Optional[String[1]]                            $path        = undef,
  Optional[Enum['posix', 'shell', 'windows']]    $provider    = undef,
  Optional[String[1]]                            $refresh     = undef,
  Optional[Boolean]                              $refreshonly = undef,
  Optional[Integer]                              $returns     = undef,
  Optional[Integer]                              $timeout     = undef,
  Optional[Integer]                              $tries       = undef,
  Optional[Integer]                              $try_sleep   = undef,
  Optional[String[1]]                            $unless      = undef,
  Optional[String[1]]                            $user        = undef,
) {
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
