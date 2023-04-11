require 'spec_helper'
describe 'types' do
  it { is_expected.to compile.with_all_deps }

  context 'with default options' do
    it { is_expected.to contain_class('types') }
  end

  context 'with mounts specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        mounts: {
          '/mnt' => {
            'device'   => '/dev/dvd',
            'fstype'   => 'iso9660',
            'atboot'   => false,
            'remounts' => true,
          },
          '/srv/nfs/home' => {
            'device'      => 'nfsserver:/export/home',
            'fstype'      => 'nfs',
            'options'     => 'rw,rsize=8192,wsize=8192',
            'remounts'    => true,
            'blockdevice' => '-',
          }
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_mount('/mnt').with(
        {
          'ensure'   => 'mounted',
          'device'   => '/dev/dvd',
          'fstype'   => 'iso9660',
          'atboot'   => false,
          'remounts' => true,
        },
      )
    end

    it do
      is_expected.to contain_exec('mkdir_p-/mnt').with(
        {
          'command' => 'mkdir -p /mnt',
          'unless'  => 'test -d /mnt',
        },
      )
    end

    it do
      is_expected.to contain_mount('/srv/nfs/home').with(
        {
          'device'      => 'nfsserver:/export/home',
          'fstype'      => 'nfs',
          'options'     => 'rw,rsize=8192,wsize=8192',
          'remounts'    => true,
          'blockdevice' => '-',
        },
      )
    end

    it do
      is_expected.to contain_exec('mkdir_p-/srv/nfs/home').with(
        {
          'command' => 'mkdir -p /srv/nfs/home',
          'unless'  => 'test -d /srv/nfs/home',
        },
      )
    end

    it { is_expected.to contain_types__mount('/mnt') }             # only needed for 100% resource coverage
    it { is_expected.to contain_types__mount('/srv/nfs/home') }    # only needed for 100% resource coverage
    it { is_expected.to contain_common__mkdir_p('/mnt') }          # only needed for 100% resource coverage
    it { is_expected.to contain_common__mkdir_p('/srv/nfs/home') } # only needed for 100% resource coverage
  end

  context 'with file_lines specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        file_lines: {
          'some_file' => {
            'path' => '/tmp/foo',
            'line' => 'option=asdf',
          },
          'some_other_file' => {
            'path'  => '/tmp/bar',
            'line'  => 'option=asdf',
            'match' => '^option',
          },
          'another_line' => {
            'ensure' => 'absent',
            'path'   => '/tmp/bar',
            'line'   => 'param=x',
          },
        },
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_file_line('some_file').with(
        {
          'path'  => '/tmp/foo',
          'line'  => 'option=asdf',
          'match' => nil,
        },
      )
    end

    it do
      is_expected.to contain_file_line('some_other_file').with(
        {
          'path'  => '/tmp/bar',
          'line'  => 'option=asdf',
          'match' => '^option',
        },
      )
    end

    it do
      is_expected.to contain_file_line('another_line').with(
        {
          'ensure' => 'absent',
          'path'   => '/tmp/bar',
          'line'   => 'param=x',
        },
      )
    end

    it { is_expected.to contain_types__file_line('some_file') }       # only needed for 100% resource coverage
    it { is_expected.to contain_types__file_line('some_other_file') } # only needed for 100% resource coverage
    it { is_expected.to contain_types__file_line('another_line') }    # only needed for 100% resource coverage
  end

  context 'with files specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        files: {
          '/localdisk' => {
            'ensure' => 'directory',
            'mode'   => '0755',
            'owner'  => 'root',
            'group'  => 'root',
          },
          '/tmp/file1' => {
            'ensure'                  => 'present',
            'mode'                    => '0777',
            'owner'                   => 'root',
            'group'                   => 'root',
            'content'                 => 'This is the content',
            'backup'                  => 'foobucket',
            'checksum'                => 'none',
            'force'                   => 'purge',
            'ignore'                  => ['.svn', '.foo'],
            'links'                   => 'follow',
            'provider'                => 'posix',
            'purge'                   => true,
            'recurse'                 => true,
            'recurselimit'            => 2,
            'replace'                 => false,
            'selinux_ignore_defaults' => false,
            'selrange'                => 's0',
            'selrole'                 => 'object_r',
            'seltype'                 => 'var_t',
            'seluser'                 => 'system_u',
            'show_diff'               => false,
            'source'                  => 'puppet://modules/types/mydir',
            'sourceselect'            => 'first',
          },
          '/tmp/file2' => {
          },
          '/softlink' => {
            'ensure' => 'link',
            'target' => '/etc/motd',
          },
          '/tmp/dir' => {
            'ensure'                  => 'directory',
            'owner'                   => 'root',
            'group'                   => 'root',
            'mode'                    => '0777',
          },
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_file('/localdisk').with(
        {
          'ensure' => 'directory',
          'mode'   => '0755',
          'owner'  => 'root',
          'group'  => 'root',
        },
      )
    end

    it do
      is_expected.to contain_file('/tmp/file1').with(
        {
          'ensure'                  => 'present',
          'mode'                    => '0777',
          'owner'                   => 'root',
          'group'                   => 'root',
          'content'                 => 'This is the content',
          'backup'                  => 'foobucket',
          'checksum'                => 'none',
          'force'                   => 'purge',
          'ignore'                  => ['.svn', '.foo'],
          'links'                   => 'follow',
          'provider'                => 'posix',
          'purge'                   => true,
          'recurse'                 => true,
          'recurselimit'            => 2,
          'replace'                 => false,
          'selinux_ignore_defaults' => false,
          'selrange'                => 's0',
          'selrole'                 => 'object_r',
          'seltype'                 => 'var_t',
          'seluser'                 => 'system_u',
          'show_diff'               => false,
          'source'                  => 'puppet://modules/types/mydir',
          'sourceselect'            => 'first',
        },
      )
    end

    it do
      is_expected.to contain_file('/tmp/file2').with(
        {
          'ensure' => 'present',
          'mode'   => '0644',
          'owner'  => 'root',
          'group'  => 'root',
        },
      )
    end

    it do
      is_expected.to contain_file('/tmp/dir').with(
        {
          'ensure' => 'directory',
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0777',
        },
      )
    end

    it { is_expected.to contain_file('/softlink') }           # only needed for 100% resource coverage
    it { is_expected.to contain_types__file('/localdisk') }   # only needed for 100% resource coverage
    it { is_expected.to contain_types__file('/softlink') }    # only needed for 100% resource coverage
    it { is_expected.to contain_types__file('/tmp/dir') }     # only needed for 100% resource coverage
    it { is_expected.to contain_types__file('/tmp/file1') }   # only needed for 100% resource coverage
    it { is_expected.to contain_types__file('/tmp/file2') }   # only needed for 100% resource coverage
  end

  context 'with packages specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        packages: {
          'pkg1' => {
            'ensure'      => 'present',
          },
          'pkg2' => {
            'ensure'      => 'absent',
          },
          'pkg3' => {
            'ensure'      => 'latest',
          },
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_package('pkg1').with(
        {
          'ensure' => 'present',
        },
      )
    end

    it do
      is_expected.to contain_package('pkg2').with(
        {
          'ensure' => 'absent',
        },
      )
    end

    it do
      is_expected.to contain_package('pkg3').with(
        {
          'ensure' => 'latest',
        },
      )
    end

    it { is_expected.to contain_types__package('pkg1') }
    it { is_expected.to contain_types__package('pkg2') } # only needed for 100% resource coverage
    it { is_expected.to contain_types__package('pkg3') } # only needed for 100% resource coverage
  end

  context 'with selboolean specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        selbooleans: {
          'nfs_export_all_ro' => {
            'value' => 'on',
          },
          'nfs_export_all_rw' => {
            'persistent' => true,
            'value'      => 'on',
          },
        }
      }
    end

    it { is_expected.to contain_class('types') }
    it do
      is_expected.to contain_selboolean('nfs_export_all_ro').with(
        {
          'value' => 'on',
        },
      )
    end

    it do
      is_expected.to contain_selboolean('nfs_export_all_rw').with(
        {
          'persistent' => true,
          'value'      => 'on',
        },
      )
    end

    it { is_expected.to contain_types__selboolean('nfs_export_all_ro') } # only needed for 100% resource coverage
    it { is_expected.to contain_types__selboolean('nfs_export_all_rw') } # only needed for 100% resource coverage
  end

  context 'with selboolean specified as an invalid type' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) { { selbooleans: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with mounts specified as an invalid type' do
    let(:params) { { mounts: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a Hash value})
    end
  end

  context 'with packages specified as an invalid type' do
    let(:params) { { packages: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with file_lines specified as an invalid type' do
    let(:params) { { file_lines: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with files specified as an invalid type' do
    let(:params) { { files: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a Hash value})
    end
  end

  context 'with cron specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        crons: {
          'cronjob-1' => {
            'command' => '/usr/local/bin/some-script.sh',
            'hour'    => '0',
            'minute'  => '10',
            'weekday' => '0',
          },
        'cronjob-2' => {
          'command' => '/usr/local/bin/script.sh',
          'hour'    => '23',
          'minute'  => '0',
          'user'    => 'www-user',
        }
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_cron('cronjob-1').with(
        {
          'ensure'  => 'present',
          'command' => '/usr/local/bin/some-script.sh',
          'hour'    => '0',
          'minute'  => '10',
          'weekday' => '0',
        },
      )
    end

    it do
      is_expected.to contain_cron('cronjob-2').with(
        {
          'ensure'  => 'present',
          'command' => '/usr/local/bin/script.sh',
          'hour'    => '23',
          'minute'  => '0',
          'user'    => 'www-user',
        },
      )
    end

    it { is_expected.to contain_types__cron('cronjob-1') } # only needed for 100% resource coverage
    it { is_expected.to contain_types__cron('cronjob-2') } # only needed for 100% resource coverage
  end

  context 'with cron specified as an invalid type' do
    let(:params) { { crons: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a Hash value})
    end
  end

  context 'with exec specified as a hash' do
    let(:facts) { { osfamily: 'RedHat' } }
    let(:params) do
      {
        execs: {
          'exec-1' => {
            'command'     => '/usr/local/bin/some-script.sh',
            'creates'     => '/tmp/touch',
            'cwd'         => '/tmp',
            'environment' => 'var=value',
            'group'       => 'group-1',
            'logoutput'   => true,
            'onlyif'      => '/onlyif.sh',
            'path'        => '/tmp',
            'provider'    => 'shell',
          },
          'exec-2' => {
            'command'     => '/usr/local/bin/script.sh',
            'refresh'     => '/refresh.sh',
            'refreshonly' => true,
            'returns'     => 242,
            'timeout'     => 3,
            'tries'       => 3,
            'try_sleep'   => 3,
            'unless'      => '/unless.sh',
            'user'        => 'tester',
          }
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_types__exec('exec-1').with(
        {
          'command'     => '/usr/local/bin/some-script.sh',
          'creates'     => '/tmp/touch',
          'cwd'         => '/tmp',
          'environment' => 'var=value',
          'group'       => 'group-1',
          'logoutput'   => true,
          'onlyif'      => '/onlyif.sh',
          'path'        => '/tmp',
          'provider'    => 'shell',
        },
      )
    end

    it do
      is_expected.to contain_types__exec('exec-2').with(
        {
          'command'     => '/usr/local/bin/script.sh',
          'refresh'     => '/refresh.sh',
          'refreshonly' => true,
          'returns'     => 242,
          'timeout'     => 3,
          'tries'       => 3,
          'try_sleep'   => 3,
          'unless'      => '/unless.sh',
          'user'        => 'tester',
        },
      )
    end

    it { is_expected.to contain_exec('exec-1') } # only needed for 100% resource coverage
    it { is_expected.to contain_exec('exec-2') } # only needed for 100% resource coverage
  end

  context 'with services specified as a hash' do
    let(:params) do
      {
        services: {
          'service-stopped' => {
            'ensure' => 'stopped',
            'enable' => 'false',
          },
          'service-running' => {
            'ensure' => 'running',
            'enable' => 'true',
          }
        }
      }
    end

    it { is_expected.to contain_class('types') }

    it do
      is_expected.to contain_service('service-stopped').with(
        {
          'ensure' => 'stopped',
          'enable' => 'false',
        },
      )
    end

    it do
      is_expected.to contain_service('service-running').with(
        {
          'ensure' => 'running',
          'enable' => 'true',
        },
      )
    end

    it { is_expected.to contain_types__service('service-stopped') } # only needed for 100% resource coverage
    it { is_expected.to contain_types__service('service-running') } # only needed for 100% resource coverage
  end

  context 'with service specified as an invalid type' do
    let(:params) { { services: ['not', 'a', 'hash'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end
end
