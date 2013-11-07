require 'spec_helper'

describe 'types::mount' do
  context 'mount with bare minimum specified' do
    let(:title) { 'dvd' }
    let(:params) do
      { :device => '/dev/dvd',
        :fstype => 'iso9660',
        :target => '/mnt',
      }
    end

    it {
      should contain_mount('types_mount_dvd').with({
        'ensure' => 'present',
        'atboot' => true,
        'device' => '/dev/dvd',
        'fstype' => 'iso9660',
        'target' => '/mnt',
      })
    }
  end

  context 'mount with all options specified' do
    let(:title) { 'fiction' }
    let(:params) do
      { :device      => '/dev/fiction',
        :fstype      => 'iso9660',
        :target      => '/mnt',
        :ensure      => 'absent',
        :atboot      => false,
        :blockdevice => '/dev/blockdevice',
        :dump        => '1',
        :options     => 'ro',
        :pass        => '1',
        :provider    => 'customprovider',
        :remounts    => true,
      }
    end

    it {
      should contain_mount('types_mount_fiction').with({
        'ensure'      => 'absent',
        'atboot'      => false,
        'device'      => '/dev/fiction',
        'fstype'      => 'iso9660',
        'target'      => '/mnt',
        'blockdevice' => '/dev/blockdevice',
        'dump'        => '1',
        'options'     => 'ro',
        'pass'        => '1',
        'provider'    => 'customprovider',
        'remounts'    => true,
      })
    }
  end

  context 'mount with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) do
      { :device      => '/dev/fiction',
        :fstype      => 'iso9660',
        :target      => '/mnt',
        :ensure      => '!invalid',
      }
    end

    it 'should fail' do
      expect {
        should include_class('types')
      }.to raise_error(Puppet::Error,/types::mount::invalid::ensure is invalid and does not match the regex./)
    end
  end
end
