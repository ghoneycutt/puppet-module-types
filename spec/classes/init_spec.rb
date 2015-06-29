require 'spec_helper'
describe 'types' do

  it { should compile.with_all_deps }

  context 'with default options' do
    it { should contain_class('types') }
  end

  context 'with mounts specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let(:params) { { :mounts => {
      '/mnt' => {
        'device'   => '/dev/dvd',
        'fstype'   => 'iso9660',
        'atboot'   => 'no',
        'remounts' => 'true',
      },
      '/srv/nfs/home' => {
        'device'      => 'nfsserver:/export/home',
        'fstype'      => 'nfs',
        'options'     => 'rw,rsize=8192,wsize=8192',
        'remounts'    => 'true',
        'blockdevice' => '-',
      }
    } } }

    it { should contain_class('types') }

    it {
      should contain_mount('/mnt').with({
        'ensure'   => 'mounted',
        'device'   => '/dev/dvd',
        'fstype'   => 'iso9660',
        'atboot'   => 'no',
        'remounts' => 'true',
      })
    }

    it {
      should contain_exec('mkdir_p-/mnt').with({
        'command' => 'mkdir -p /mnt',
        'unless'  => 'test -d /mnt',
      })
    }

    it {
      should contain_mount('/srv/nfs/home').with({
        'device'      => 'nfsserver:/export/home',
        'fstype'      => 'nfs',
        'options'     => 'rw,rsize=8192,wsize=8192',
        'remounts'    => 'true',
        'blockdevice' => '-',
      })
    }

    it {
      should contain_exec('mkdir_p-/srv/nfs/home').with({
        'command' => 'mkdir -p /srv/nfs/home',
        'unless'  => 'test -d /srv/nfs/home',
      })
    }
  end

  context 'with file_lines specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let :params do
      {
        :file_lines_hiera_merge => 'false',
        :file_lines => {
          'some_file' => {
            'path' => '/tmp/foo',
            'line' => 'option=asdf',
          },
          'some_other_file' => {
            'path'  => '/tmp/bar',
            'line'  => 'option=asdf',
            'match' => '^option',
          },
        },
      }
    end

    it { should contain_class('types') }

    it {
      should contain_file_line('some_file').with({
        'path'  => '/tmp/foo',
        'line'  => 'option=asdf',
        'match' => nil,
      })
    }

    it {
      should contain_file_line('some_other_file').with({
        'path'  => '/tmp/bar',
        'line'  => 'option=asdf',
        'match' => '^option',
      })
    }
  end

  context 'with files specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let(:params) { { :files => {
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
    } } }

    it { should contain_class('types') }

    it {
      should contain_file('/localdisk').with({
        'ensure'  => 'directory',
        'mode'    => '0755',
        'owner'   => 'root',
        'group'   => 'root',
      })
    }

    it {
      should contain_file('/tmp/file1').with({
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
      })
    }

    it {
      should contain_file('/tmp/file2').with({
        'ensure'  => 'present',
        'mode'    => '0644',
        'owner'   => 'root',
        'group'   => 'root',
      })
    }

    it {
      should contain_file('/tmp/dir').with({
        'ensure'  => 'directory',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0777',
      })
    }
  end

  context 'with packages specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let :params do
      {
        :packages_hiera_merge => 'false',
        :packages => {
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

    it { should contain_class('types') }

    it {
      should contain_package('pkg1').with({
        'ensure' => 'present',
      })
    }

    it {
      should contain_package('pkg2').with({
        'ensure' => 'absent',
      })
    }

    it {
      should contain_package('pkg3').with({
        'ensure' => 'latest',
      })
    }

  end

  context 'with mounts specified as an invalid type' do
    let(:params) { { :mounts => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error,/\["not", "a", "hash"\] is not a Hash\./)
    end
  end

  context 'with packages specified as an invalid type' do
    let(:params) { { :packages => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with file_lines specified as an invalid type' do
    let(:params) { { :file_lines => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with files specified as an invalid type' do
    let(:params) { { :files => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error,/\["not", "a", "hash"\] is not a Hash\./)
    end
  end

  context 'with cron specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let(:params) { { :crons => {
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
    } } }

    it { should contain_class('types') }

    it {
      should contain_cron('cronjob-1').with({
        'ensure'  => 'present',
        'command' => '/usr/local/bin/some-script.sh',
        'hour'    => '0',
        'minute'  => '10',
        'weekday' => '0',
      })
    }
    it {
      should contain_cron('cronjob-2').with({
        'ensure'  => 'present',
        'command' => '/usr/local/bin/script.sh',
        'hour'    => '23',
        'minute'  => '0',
        'user'    => 'www-user',
      })
    }
  end

  context 'with cron specified as an invalid type' do
    let(:params) { { :crons => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error,/\["not", "a", "hash"\] is not a Hash\./)
    end
  end

  context 'with services specified as a hash' do
    let :params do
      {
        :services_hiera_merge => 'false',
        :services => {
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

    it { should contain_class('types') }

    it {
      should contain_service('service-stopped').with({
        'ensure' => 'stopped',
        'enable' => 'false',
      })
    }
    it {
      should contain_service('service-running').with({
        'ensure' => 'running',
        'enable' => 'true',
      })
    }
  end

  context 'with service specified as an invalid type' do
    let(:params) { { :services => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end
end
