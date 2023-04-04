require 'spec_helper'
describe 'types::file' do
  let(:title) { '/tmp/foo' }

  context 'file with no options specified' do
    it do
      is_expected.to contain_file('/tmp/foo').with(
        {
          'ensure' => 'present',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
        },
      )
    end
  end

  context 'file with all options specified' do
    let(:params) do
      {
        ensure: 'present',
        mode: '0777',
        owner: 'root',
        group: 'root',
        content: 'This is the content',
        backup: 'foobucket',
        checksum: 'none',
        force: 'purge',
        ignore: ['.svn', '.foo'],
        links: 'follow',
        provider: 'posix',
        purge: true,
        recurse: true,
        recurselimit: 2,
        replace: false,
        selinux_ignore_defaults: false,
        selrange: 's0',
        selrole: 'object_r',
        seltype: 'var_t',
        seluser: 'system_u',
        show_diff: false,
        source: 'puppet://modules/types/mydir',
        sourceselect: 'first',
      }
    end

    it do
      is_expected.to contain_file('/tmp/foo').with(
        {
          'ensure'                  => 'present',
          'mode'                    => '0777',
          'owner'                   => 'root',
          'group'                   => 'root',
          'content'                 => 'This is the content',
          'backup'                  => 'foobucket',
          'checksum'                => 'none',
          'force'                   => 'purge',
          'ignore'                  => ['.svn', '.foo'],
          'links'                   => 'follow',
          'provider'                => 'posix',
          'purge'                   => true,
          'recurse'                 => true,
          'recurselimit'            => 2,
          'replace'                 => false,
          'selinux_ignore_defaults' => false,
          'selrange'                => 's0',
          'selrole'                 => 'object_r',
          'seltype'                 => 'var_t',
          'seluser'                 => 'system_u',
          'show_diff'               => false,
          'source'                  => 'puppet://modules/types/mydir',
          'sourceselect'            => 'first',
        },
      )
    end
  end

  describe 'with ensure' do
    ['present', 'absent', 'file', 'directory', 'link'].each do |value|
      context "set to #{value}" do
        let(:params) { { ensure: value } }

        it {
          is_expected.to contain_file('/tmp/foo').with(
            {
              'ensure' => value,
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
            },
          )
        }
      end
    end
  end

  context 'file with invalid ensure' do
    let(:params) { { ensure: 'invalid' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{types::file::/tmp/foo::ensure is invalid and does not match the regex\.})
    end
  end

  describe 'file with mode set to invalid' do
    ['666', 665, '10666', 'foo', true].each do |value|
      context "value of #{value}" do
        let(:params) { { mode: 'invalid' } }

        it 'fails' do
          expect {
            is_expected.to contain_class('types')
          }.to raise_error(Puppet::Error, %r{types::file::/tmp/foo::mode must be exactly 4 digits\.})
        end
      end
    end
  end

  context 'file with name that is not an absolute path' do
    let(:params) { { ensure: 'invalid/path' } }

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{types::file::/tmp/foo::ensure is invalid and does not match the regex\.})
    end
  end
end
