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
        'require'  => 'Common::Mkdir_p[/mnt]',
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
        'require'  => 'Common::Mkdir_p[/srv/nfs/home]',
      })
    }

    it {
      should contain_exec('mkdir_p-/srv/nfs/home').with({
        'command' => 'mkdir -p /srv/nfs/home',
        'unless'  => 'test -d /srv/nfs/home',
      })
    }
  end

  context 'with mounts specified as an invalid type' do
    let(:params) { { :mounts => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with cron specified as a hash' do
    let(:facts) { { :osfamily => 'RedHat' } }
    let(:params) { { :cron => {
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
    let(:params) { { :cron => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end
end
