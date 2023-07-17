require 'spec_helper'
describe 'types::selboolean' do
  let(:title) { 'nfs_export_all_ro' }

  context 'selboolean with all options specified' do
    let(:params) do
      {
        persistent: true,
        value:      'on',
        provider:   'getsebool',
      }
    end

    it do
      is_expected.to contain_selboolean('nfs_export_all_ro').only_with(
        {
          'persistent' => true,
          'value'      => 'on',
          'provider'   => 'getsebool',
        },
      )
    end
  end

  describe 'with value' do
    ['on', 'off'].each do |value|
      context "set to #{value}" do
        let(:params) { { value: value } }

        it do
          is_expected.to contain_selboolean('nfs_export_all_ro').with(
            {
              'persistent' => false,
              'value'      => value,
            },
          )
        end
      end
    end
  end

  context 'selboolean with invalid value for provider' do
    let(:params) { { provider: false } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'selboolean with invalid value for persistent' do
    let(:params) { { persistent: 'invalid setting' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'selboolean with invalid value for value' do
    let(:params) { { value: 'invalid setting' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'selboolean with no value - value is mandatory' do
    let(:params) { { persistent: false } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error)
    end
  end
end
