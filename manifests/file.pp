# == Define: types::file
#
define types::file (
  $path                    = $name,
  $content                 = undef,
  $ensure                  = present,
  $backup                  = main,
  $checksum                = md5,
  $force                   = undef,
  $group                   = undef,
  $ignore                  = undef,
  $links                   = undef,
  $mode                    = undef,
  $owner                   = undef,
  $provider                = undef,
  $purge                   = undef,
  $recurse                 = false,
  $recurselimit            = undef,
  $replace                 = true,
  $selinux_ignore_defaults = undef,
  $selrange                = undef,
  $selrole                 = undef,
  $seltype                 = undef,
  $seluser                 = undef,
  $show_diff               = true,
  $source                  = undef,
  $sourceselect            = undef,
  $target                  = undef,
) {

  # validate params
  validate_re($ensure, '^(present)|(absent)|(file)|(directory)|(link)$',
    "types::file::${name}::ensure is invalid and does not match the regex.")
  validate_absolute_path($name)

  file { $name:
    ensure                  => $ensure,
    owner                   => $owner,
    group                   => $group,
    mode                    => $mode,
    content                 => $content,
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
