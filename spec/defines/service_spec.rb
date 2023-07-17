require 'spec_helper'
describe 'types::service' do
  context 'service with bare minimum specified' do
    let(:title) { 'service_minimum' }

    it do
      is_expected.to contain_service('service_minimum').with(
        {
          'ensure' => 'running',
          'enable' => true,
        },
      )
    end
  end

  context 'service with all options specified' do
    let(:title) { 'service_maximum' }
    let(:params) do
      {
        ensure:     'stopped',
        binary:     '/bin/true',
        control:    'SERVICE_MAXIMUM_START',
        enable:     'manual',
        hasrestart: 'true',
        hasstatus:  'false',
        manifest:   '/bin/manifest',
        path:       '/etc/init.d',
        pattern:    'service_maximum',
        provider:   'init',
        restart:    '/bin/restart',
        start:      '/bin/start',
        status:     '/bin/status',
        stop:       '/bin/stop',
      }
    end

    it do
      is_expected.to contain_service('service_maximum').only_with(
        {
          'ensure'     => 'stopped',
          'binary'     => '/bin/true',
          'control'    => 'SERVICE_MAXIMUM_START',
          'enable'     => 'manual',
          'hasrestart' => 'true',
          'hasstatus'  => 'false',
          'manifest'   => '/bin/manifest',
          'path'       => '/etc/init.d',
          'pattern'    => 'service_maximum',
          'provider'   => 'init',
          'restart'    => '/bin/restart',
          'start'      => '/bin/start',
          'status'     => '/bin/status',
          'stop'       => '/bin/stop',
        },
      )
    end
  end

  context 'service with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) { { ensure: 'invalid' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a value of type Boolean or Enum})
    end
  end

  describe 'with parameter enable' do
    ['true', true, 'false', false, 'manual'].each do |value|
      context "set to #{value}" do
        let(:title) { 'my_service' }
        let(:params) { { enable: value } }

        it do
          is_expected.to contain_service('my_service').with(
            {
              'enable' => value,
            },
          )
        end
      end
    end

    context 'set to an invalid string' do
      let(:title) { 'invalid' }
      let(:params) { { enable: 'invalid' } }

      it 'fails' do
        expect {
          is_expected.to contain_class('types')
        }.to raise_error(Puppet::Error, %r{expects a value of type Boolean or Enum})
      end
    end

    context 'set to an invalid type (non-string and non-boolean)' do
      let(:title) { 'invalid_type' }
      let(:params) { { enable: ['invalid', 'type'] } }

      it 'fails' do
        expect {
          is_expected.to contain_class('types')
        }.to raise_error(Puppet::Error, %r{expects a value of type Boolean or Enum})
      end
    end
  end
end
