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
    let(:facts) do
      {
        os: { family: 'Redhat' },
        osfamily: 'RedHat', # needed for common module :(
      }
    end

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

    it { is_expected.to contain_common__mkdir_p('/mnt') }
  end

  context 'mount with all options specified' do
    let(:title) { '/mnt' }
    let(:params) do
      {
        device:      '/dev/fiction',
        fstype:      'iso9660',
        ensure:      'absent',
        atboot:      false,
        blockdevice: '/dev/blockdevice',
        dump:        '1',
        options:     'ro',
        pass:        '1',
        provider:    'customprovider',
        remounts:    true,
      }
    end

    it do
      is_expected.to contain_mount('/mnt').only_with(
        {
          'ensure'      => 'absent',
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
      }.to raise_error(Puppet::Error, %r{expects a match for Enum})
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
        is_expected.to contain_mount('/mnt/test').with(
          {
            'ensure' => 'absent',
            'device' => '/dev/fiction',
            'fstype' => 'iso9660',
          },
        )
      end

      it { is_expected.not_to contain_exec('mkdir_p-/mnt/test') }
    end
  end

  describe 'with \'options\' parameter set to \'defaults\'' do
    context 'on osfamily Solaris' do
      let(:title) { '/mnt' }
      let(:params) do
        {
          device:  '/dev/fiction',
          fstype:  'iso9660',
          options: 'defaults',
        }
      end
      let(:facts) do
        {
          os: { family: 'Solaris' },
          osfamily: 'Solaris', # needed for common module :(
        }
      end

      it do
        is_expected.to contain_mount('/mnt').with(
          {
            'ensure'  => 'mounted',
            'device'  => '/dev/fiction',
            'fstype'  => 'iso9660',
            'options' => '-',
          },
        )
      end

      it { is_expected.to contain_common__mkdir_p('/mnt') }
    end

    context 'on osfamily that is not Solaris' do
      let(:title) { '/mnt' }
      let(:params) do
        {
          device:  '/dev/fiction',
          fstype:  'iso9660',
          options: 'defaults',
        }
      end
      let(:facts) do
        {
          os: { family: 'Debian' },
          osfamily: 'Debian', # needed for common module :(
        }
      end

      it do
        is_expected.to contain_mount('/mnt').with(
          {
            'ensure'  => 'mounted',
            'device'  => '/dev/fiction',
            'fstype'  => 'iso9660',
            'options' => 'defaults',
          },
        )
      end
    end
  end
end
