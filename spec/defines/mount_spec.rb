require 'spec_helper'

describe 'types::mount' do
  context 'mount with bare minimum specified' do
    let(:title) { '/mnt' }
    let(:params) do
      {
        device: '/dev/dvd',
        fstype: 'iso9660',
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_mount('/mnt').with(
        {
          'ensure' => 'mounted',
          'name'   => '/mnt',
          'atboot' => true,
          'device' => '/dev/dvd',
          'fstype' => 'iso9660',
        },
      )
    end
  end

  context 'mount with all options specified' do
    let(:title) { '/mnt' }
    let(:params) do
      {
        device: '/dev/fiction',
        fstype: 'iso9660',
        ensure: 'absent',
        atboot: false,
        blockdevice: '/dev/blockdevice',
        dump: '1',
        options: 'ro',
        pass: '1',
        provider: 'customprovider',
        remounts: true,
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_mount('/mnt').with(
        {
          'ensure' => 'absent',
          'atboot'      => false,
          'device'      => '/dev/fiction',
          'fstype'      => 'iso9660',
          'name'        => '/mnt',
          'blockdevice' => '/dev/blockdevice',
          'dump'        => '1',
          'options'     => 'ro',
          'pass'        => '1',
          'provider'    => 'customprovider',
          'remounts'    => true,
        },
      )
    end
  end

  context 'mount with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) do
      {
        device: '/dev/fiction',
        fstype: 'iso9660',
        target: '/mnt',
        ensure: '!invalid',
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{types::mount::invalid::ensure is invalid and does not match the regex\.})
    end
  end

  describe 'with \'ensure\' parameter set to \'absent\'' do
    context 'on osfamily RedHat' do
      let(:title) { '/mnt/test' }
      let(:params) do
        {
          ensure: 'absent',
          device: '/dev/fiction',
          fstype: 'iso9660',
        }
      end
      let(:facts) { { osfamily: 'RedHat' } }

      it do
        is_expected.not_to contain_exec('mkdir_p-/mnt/test')
      end
    end
  end

  describe 'with \'options\' parameter set to \'defaults\'' do
    context 'on osfamily Solaris' do
      let(:title) { '/mnt' }
      let(:params) do
        {
          device: '/dev/fiction',
          fstype: 'iso9660',
          options: 'defaults',
        }
      end
      let(:facts) { { osfamily: 'Solaris' } }

      it do
        is_expected.to contain_mount('/mnt').with(
          {
            'ensure' => 'mounted',
            'device'  => '/dev/fiction',
            'fstype'  => 'iso9660',
            'options' => '-',
          },
        )
      end
    end

    context 'on osfamily that is not Solaris' do
      let(:title) { '/mnt' }
      let(:params) do
        {
          device: '/dev/fiction',
          fstype: 'iso9660',
          options: 'defaults',
        }
      end
      let(:facts) { { osfamily: 'Debian' } }

      it do
        is_expected.to contain_mount('/mnt').with(
          {
            'ensure' => 'mounted',
            'device'      => '/dev/fiction',
            'fstype'      => 'iso9660',
            'options'     => 'defaults',
          },
        )
      end
    end
  end
end
