require 'spec_helper'
describe 'types::exec' do
  let(:title) { 'testing' }
  let(:facts) { { osfamily: 'RedHat' } }

  context 'exec with no parameter specified' do
    it 'fails' do
      expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error, %r{(expects a value for parameter \'command\'|Must pass command to)})
    end
  end

  context 'exec with bare minimum specified' do
    let(:params) { { command: '/spec/testing.sh' } }

    it { is_expected.to contain_exec('testing').only_with_command('/spec/testing.sh') }
  end

  context 'exec with all options specified' do
    let(:title) { 'testing' }
    let(:params) do
      {
        command:     '/spec/testing.sh',
        creates:     '/creates',
        cwd:         '/spec',
        environment: 'test=true',
        group:       'group',
        logoutput:   true,
        onlyif:      '/onlyif.sh',
        path:        '/path',
        provider:    'shell',
        refresh:     '/refresh.sh',
        refreshonly: true,
        returns:     242,
        timeout:     3,
        tries:       3,
        try_sleep:   3,
        unless:      '/unless.sh',
        user:        'tester',
      }
    end

    it do
      is_expected.to contain_exec('testing').with(
        {
          'command'     => '/spec/testing.sh',
          'creates'     => '/creates',
          'cwd'         => '/spec',
          'environment' => 'test=true',
          'group'       => 'group',
          'logoutput'   => true,
          'onlyif'      => '/onlyif.sh',
          'path'        => '/path',
          'provider'    => 'shell',
          'refresh'     => '/refresh.sh',
          'refreshonly' => true,
          'returns'     => 242,
          'timeout'     => 3,
          'tries'       => 3,
          'try_sleep'   => 3,
          'unless'      => '/unless.sh',
          'user'        => 'tester',
        },
      )
    end
  end

  context 'exec with invalid provider' do
    let(:params) { { provider: 'invalid', command: '/spec/testing.sh' } }

    it 'fails' do
      expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error, %r{expects an undef value or a match for Enum})
    end
  end

  describe 'variable type and content validations' do
    mandatory_params = { command: '/spec/testing.sh' }
    validations = {
      'validate_absolute_path' => {
        name:    ['creates', 'cwd'],
        valid:   ['/absolute/filepath', '/absolute/directory/'],
        invalid: ['./relative/path', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, nil],
        message: 'expects a Stdlib::Absolutepath',
      },
      'validate_re' => {
        name:    ['provider'],
        valid:   ['posix', 'shell', 'windows'],
        invalid: ['string', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, nil],
        message: 'expects an undef value or a match for Enum',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [mandatory_params, var[:params], { "#{var_name}": valid, }].reduce(:merge) }

            it { is_expected.to compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [mandatory_params, var[:params], { "#{var_name}": invalid, }].reduce(:merge) }

            it 'fails' do
              expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error, %r{#{var[:message]}})
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
