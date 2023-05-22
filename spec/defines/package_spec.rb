require 'spec_helper'
describe 'types::package' do
  context 'package with bare minimum specified' do
    let(:title) { 'pkg1' }
    let(:facts) { { osfamily: 'RedHat' } }

    it { is_expected.to contain_package('pkg1').with_ensure('present') }
  end

  context 'package with all options specified' do
    let(:title) { 'pkg1' }
    let(:params) do
      {
        ensure:            'installed',
        adminfile:         '/path/to/adminfile',
        configfiles:       'keep',
        enable_only:       true,
        install_options:   '--installoption',
        provider:          'yum',
        responsefile:      '/path/to/responsefile',
        source:            'http://source/URL/',
        uninstall_options: '--uninstall_option',
      }
    end

    it do
      is_expected.to contain_package('pkg1').only_with(
        {
          'ensure'            => 'installed',
          'adminfile'         => '/path/to/adminfile',
          'configfiles'       => 'keep',
          'enable_only'       => true,
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
    let(:params) { { configfiles: 'invalid' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects an undef value or a match for Enum})
    end
  end

  context 'package with invalid type for ensure' do
    let(:title) { 'invalidtype' }
    let(:params) { { ensure: ['invalid', 'type'] } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a match for Enum})
    end
  end

  context 'package with invalid responsefile' do
    let(:title) { 'pkg1' }
    let(:params) { { responsefile: 'invalid/path' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a Stdlib::Absolutepath})
    end
  end

  context 'package with invalid enable_only' do
    let(:title) { 'pkg1' }
    let(:params) { { enable_only: 'invalid' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a value of type Undef or Boolean})
    end
  end
end
