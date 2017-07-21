require 'spec_helper'
describe 'types::exec' do
  let(:title) { 'testing' }
  let(:facts) { { :osfamily => 'RedHat' } }

  context 'exec with no parameter specified' do
    it 'should fail' do
      expect { should contain_class(subject) }.to raise_error(Puppet::Error, /(expects a value for parameter \'command\'|Must pass command to)/)
    end
  end

  context 'exec with bare minimum specified' do
    let(:params) { { :command => '/spec/testing.sh' } }
    it { should contain_exec('testing').only_with_command('/spec/testing.sh') }
  end

  context 'exec with all options specified' do
    let(:title) { 'testing' }
    let(:params) do
      {
        :command     => '/spec/testing.sh',
        :creates     => '/creates',
        :cwd         => '/spec',
        :environment => 'test=true',
        :group       => 'group',
        :logoutput   => true,
        :onlyif      => '/onlyif.sh',
        :path        => '/path',
        :provider    => 'shell',
        :refresh     => '/refresh.sh',
        :refreshonly => true,
        :returns     => 242,
        :timeout     => 3,
        :tries       => 3,
        :try_sleep   => 3,
        :unless      => '/unless.sh',
        :user        => 'tester',
      }
    end

    it {
      should contain_exec('testing').with({
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
      })
    }
  end

  context 'exec with invalid provider' do
    let(:params) { { :provider=> 'invalid', :command => '/spec/testing.sh' } }
    it 'should fail' do
      expect { should contain_class(subject) }.to raise_error(Puppet::Error, /types::exec::testing::provider is invalid and does not match the regex/)
    end
  end

  describe 'variable type and content validations' do
    mandatory_params = { :command => '/spec/testing.sh' }
    validations = {
      'validate_absolute_path' => {
        :name    => %w[creates cwd],
        :valid   => ['/absolute/filepath', '/absolute/directory/'],
        :invalid => ['./relative/path', %w[array], { 'ha' => 'sh' }, 3, 2.42, true, nil],
        :message => 'is not an absolute path',
      },
      'validate_re' => {
        :name    => %w[provider],
        :valid   => %w[posix shell windows],
        :invalid => ['string', %w[array], { 'ha' => 'sh' }, 3, 2.42, true, nil],
        :message => 'types::exec::testing::provider is invalid and does not match the regex',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => valid, }].reduce(:merge) }
            it { should compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => invalid, }].reduce(:merge) }
            it 'should fail' do
              expect { should contain_class(subject) }.to raise_error(Puppet::Error, /#{var[:message]}/)
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
