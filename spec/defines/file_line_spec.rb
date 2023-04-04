require 'spec_helper'
describe 'types::file_line' do
  let(:title) { 'some_file' }

  context 'file_line with minimal parameters specified (path and line)' do
    let(:params) do
      {
        path: '/tmp/foo',
        line: 'option=asdf',
      }
    end

    it do
      is_expected.to contain_file_line('some_file').with(
        {
          'path' => '/tmp/foo',
          'line'  => 'option=asdf',
          'match' => nil,
        },
      )
    end
  end

  context 'file_line with all parameters specified' do
    let(:params) do
      {
        ensure: 'present',
        path: '/tmp/foo',
        line: 'option=asdf',
        match: '^option',
      }
    end

    it do
      is_expected.to contain_file_line('some_file').with(
        {
          'ensure' => 'present',
          'path'   => '/tmp/foo',
          'line'   => 'option=asdf',
          'match'  => '^option',
        },
      )
    end
  end

  describe 'with an invalid path for the path parameter' do
    let(:params) do
      {
        path: 'invalid/path',
        line: 'option=asdf',
        match: '^option',
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{"invalid/path" is not an absolute path})
    end
  end

  describe 'with an invalid ensure parameter' do
    let(:params) do
      {
        ensure: '!invalid',
        path: '/tmp/foo',
        line: 'option=asdf',
        match: '^option',
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{types::file_line::some_file::ensure is invalid and does not match the regex\.})
    end
  end

  describe 'with an invalid type' do
    context 'for the path parameter' do
      let(:params) do
        {
          path: true,
          line: 'option=asdf',
          match: '^option',
        }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('types')
        }.to raise_error(Puppet::Error, %r{true is not an absolute path})
      end
    end

    context 'for the line parameter' do
      let(:params) do
        {
          path: '/tmp/foo',
          line: ['invalid', 'type'],
          match: '^option',
        }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('types')
        }.to raise_error(Puppet::Error, %r{\["invalid", "type"\] is not a string})
      end
    end

    context 'for the match parameter' do
      let(:params) do
        {
          path: '/tmp/foo',
          line: 'option=asdf',
          match: ['invalid', 'type'],
        }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('types')
        }.to raise_error(Puppet::Error, %r{\["invalid", "type"\] is not a string})
      end
    end
  end
end
