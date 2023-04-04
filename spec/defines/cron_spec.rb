require 'spec_helper'
describe 'types::cron' do
  context 'cron with bare minimum specified' do
    let(:title) { 'cronjob-1' }
    let(:params) do
      { command: '/usr/local/bin/script.sh' }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_cron('cronjob-1').with(
        {
          'ensure'  => 'present',
          'command' => '/usr/local/bin/script.sh',
        },
      )
    end
  end

  context 'cron with all options specified' do
    let(:title) { 'cronjob-1' }
    let(:params) do
      {
        command: '/usr/local/bin/script.sh',
        ensure: 'absent',
        environment: '/bin:/usr/bin',
        hour: '1',
        minute: '10',
        month: 'Jan',
        monthday: '1',
        provider: 'crontab',
        special: 'absent',
        target: 'root',
        user: 'root',
        weekday: '6',
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_cron('cronjob-1').with(
        {
          'ensure'      => 'absent',
          'command'     => '/usr/local/bin/script.sh',
          'environment' => '/bin:/usr/bin',
          'hour'        => '1',
          'minute'      => '10',
          'month'       => 'Jan',
          'monthday'    => '1',
          'provider'    => 'crontab',
          'special'     => 'absent',
          'target'      => 'root',
          'user'        => 'root',
          'weekday'     => '6',
        },
      )
    end
  end

  context 'cron with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) do
      {
        command: '/usr/local/bin/script',
        hour: '2',
        minute: '0',
        ensure: '!invalid',
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{types::cron::invalid::ensure is invalid and does not match the regex\.})
    end
  end
end
