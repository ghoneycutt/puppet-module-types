# @summary Define for file types
#   For a full description of the exec type check: https://www.puppet.com/docs/puppet/7/types/file.html
#
# @param ensure
#   Value passed to ensure attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-ensure for more information.
#
# @param owner
#   Value passed to owner attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-owner for more information.
#
# @param group
#   Value passed to group attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-group for more information.
#
# @param mode
#   Value passed to mode attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-mode for more information.
#
# @param backup
#   Value passed to backup attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-backup for more information.
#
# @param checksum
#   Value passed to checksum attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-checksum for more information.
#
# @param content
#   Value passed to content attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-content for more information.
#
# @param force
#   Value passed to force attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-force for more information.
#
# @param ignore
#   Value passed to ignore attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-ignore for more information.
#
# @param links
#   Value passed to links attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-links for more information.
#
# @param provider
#   Value passed to provider attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-provider for more information.
#
# @param purge
#   Value passed to purge attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-purge for more information.
#
# @param recurse
#   Value passed to recurse attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-recurse for more information.
#
# @param recurselimit
#   Value passed to recurselimit attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-recurselimit for more information.
#
# @param replace
#   Value passed to replace attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-replace for more information.
#
# @param selinux_ignore_defaults
#   Value passed to selinux_ignore_defaults attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-selinux_ignore_defaults for more information.
#
# @param selrange
#   Value passed to selrange attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-selrange for more information.
#
# @param selrole
#   Value passed to selrole attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-selrole for more information.
#
# @param seltype
#   Value passed to seltype attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-seltype for more information.
#
# @param seluser
#   Value passed to seluser attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-seluser for more information.
#
# @param show_diff
#   Value passed to show_diff attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-show_diff for more information.
#
# @param source
#   Value passed to source attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-source for more information.
#
# @param sourceselect
#   Value passed to sourceselect attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-sourceselect for more information.
#
# @param target
#   Value passed to target attribute. Unused if empty.
#   Check https://www.puppet.com/docs/puppet/7/types/file.html#file-attribute-target for more information.
#
define types::file (
  Enum['present', 'absent', 'file', 'directory', 'link'] $ensure                  = 'present',
  String[1]                                              $owner                   = 'root',
  String[1]                                              $group                   = 'root',
  Stdlib::Filemode                                       $mode                    = '0644',
  Optional[String[1]]                                    $backup                  = undef,
  Optional[String[1]]                                    $checksum                = undef,
  Optional[String[1]]                                    $content                 = undef,
  Optional[String[1]]                                    $force                   = undef,
  Optional[Variant[String[1], Array[String[1]]]]         $ignore                  = undef,
  Optional[String[1]]                                    $links                   = undef,
  Optional[String[1]]                                    $provider                = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]]          $purge                   = undef,
  Optional[Variant[Boolean, Enum['remote']]]             $recurse                 = undef,
  Optional[Integer]                                      $recurselimit            = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]]          $replace                 = undef,
  Optional[Boolean]                                      $selinux_ignore_defaults = undef,
  Optional[String[1]]                                    $selrange                = undef,
  Optional[String[1]]                                    $selrole                 = undef,
  Optional[String[1]]                                    $seltype                 = undef,
  Optional[String[1]]                                    $seluser                 = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]]          $show_diff               = undef,
  Optional[String[1]]                                    $source                  = undef,
  Optional[String[1]]                                    $sourceselect            = undef,
  Optional[String[1]]                                    $target                  = undef,
) {
  assert_type(Stdlib::Absolutepath, $name)

  file { $name:
    ensure                  => $ensure,
    owner                   => $owner,
    group                   => $group,
    mode                    => $mode,
    checksum                => $checksum,
    content                 => $content,
    backup                  => $backup,
    force                   => $force,
    ignore                  => $ignore,
    links                   => $links,
    provider                => $provider,
    purge                   => $purge,
    recurse                 => $recurse,
    recurselimit            => $recurselimit,
    replace                 => $replace,
    selinux_ignore_defaults => $selinux_ignore_defaults,
    selrange                => $selrange,
    selrole                 => $selrole,
    seltype                 => $seltype,
    seluser                 => $seluser,
    show_diff               => $show_diff,
    source                  => $source,
    sourceselect            => $sourceselect,
    target                  => $target,
  }
}
