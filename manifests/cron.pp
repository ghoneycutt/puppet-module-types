# @summary Define for cron types
#   For a full description of the cron type check: https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md
#
# @param command
#   Value passed to command attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#command for more information.
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#ensure for more information.
#
# @param environment
#   Value passed to environment attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#environment for more information.
#
# @param hour
#   Value passed to hour attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#hour for more information.
#
# @param minute
#   Value passed to minute attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#minute for more information.
#
# @param month
#   Value passed to month attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#month for more information.
#
# @param monthday
#   Value passed to monthday attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#monthday for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#provider for more information.
#
# @param special
#   Value passed to special attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#special for more information.
#
# @param target
#   Value passed to target attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#target for more information.
#
# @param user
#   Value passed to user attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#user for more information.
#
# @param weekday
#   Value passed to weekday attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-cron_core/blob/main/REFERENCE.md#weekday for more information.
#
define types::cron (
  String[1]                 $command,
  Enum['present', 'absent'] $ensure      = 'present',
  Optional[String[1]]       $environment = undef,
  Optional[String[1]]       $hour        = undef,
  Optional[String[1]]       $minute      = undef,
  Optional[String[1]]       $month       = undef,
  Optional[String[1]]       $monthday    = undef,
  Optional[String[1]]       $provider    = undef,
  Optional[String[1]]       $special     = undef,
  Optional[String[1]]       $target      = undef,
  Optional[String[1]]       $user        = undef,
  Optional[String[1]]       $weekday     = undef,
) {
  cron { $name:
    ensure      => $ensure,
    command     => $command,
    environment => $environment,
    hour        => $hour,
    minute      => $minute,
    month       => $month,
    monthday    => $monthday,
    provider    => $provider,
    special     => $special,
    target      => $target,
    user        => $user,
    weekday     => $weekday,
  }
}
