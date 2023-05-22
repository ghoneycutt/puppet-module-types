# @summary Define for selboolean types
#   For a full description of the cron type check: https://github.com/puppetlabs/puppetlabs-selinux_core/blob/main/REFERENCE.md
#
# @param value
#   Value passed to value attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-selinux_core/blob/main/REFERENCE.md#value for more information.
#
# @param persistent
#   Value passed to persistent attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-selinux_core/blob/main/REFERENCE.md#persistent for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://github.com/puppetlabs/puppetlabs-selinux_core/blob/main/REFERENCE.md#provider for more information.
#
define types::selboolean (
  Enum['on', 'off']   $value,
  Boolean             $persistent = false,
  Optional[String[1]] $provider   = undef,
) {
  selboolean { $name:
    value      => $value,
    persistent => $persistent,
    provider   => $provider,
  }
}
