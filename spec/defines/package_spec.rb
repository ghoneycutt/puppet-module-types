require 'spec_helper'
describe 'types::package' do
  context 'package with bare minimum specified' do
    let(:title) { 'pkg1' }

    it do
      is_expected.to contain_package('pkg1').with(
        {
          'ensure' => 'present',
        },
      )
    end
  end

  context 'package with all options specified' do
    let(:title) { 'pkg1' }
    let(:params) do
      {
        ensure:            'installed',
        adminfile:         '/path/to/adminfile',
        configfiles:       'keep',
        install_options:   '--installoption',
        provider:          'yum',
        responsefile:      '/path/to/responsefile',
        source:            'http://source/URL/',
        uninstall_options: '--uninstall_option',
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_package('pkg1').with(
        {
          'ensure'            => 'installed',
          'adminfile'         => '/path/to/adminfile',
          'configfiles'       => 'keep',
          'install_options'   => '--installoption',
          'provider'          => 'yum',
          'responsefile'      => '/path/to/responsefile',
          'source'            => 'http://source/URL/',
          'uninstall_options' => '--uninstall_option',
        },
      )
    end
  end

  context 'package with invalid configfiles' do
    let(:title) { 'pkg1' }
    let(:params) do
      {
        configfiles: 'invalid',
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects an undef value or a match for Enum})
    end
  end

  context 'package with invalid type for ensure' do
    let(:title) { 'invalidtype' }
    let(:params) do
      {
        ensure: ['invalid', 'type'],
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a match for Enum})
    end
  end

  context 'package with invalid responsefile' do
    let(:title) { 'pkg1' }
    let(:params) do
      {
        responsefile: 'invalid/path'
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a Stdlib::Absolutepath})
    end
  end
end
