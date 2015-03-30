require 'spec_helper'
describe 'types::file_line' do
  let(:title) { 'some_file' }

  context 'file_line with minimal parameters specified (path and line)' do
    let(:params) do
      {
        :path => '/tmp/foo',
        :line => 'option=asdf',
      }
    end

    it { should contain_file_line('some_file').with({
        'path'  => '/tmp/foo',
        'line'  => 'option=asdf',
        'match' => nil,
      })
    }
  end

  context 'file_line with all parameters specified' do
    let(:params) do
      {
        :path  => '/tmp/foo',
        :line  => 'option=asdf',
        :match => '^option',
      }
    end

    it { should contain_file_line('some_file').with({
        'path'  => '/tmp/foo',
        'line'  => 'option=asdf',
        'match' => '^option',
      })
    }
  end

  describe 'with an invalid path for the path parameter' do
    let(:params) do
      {
        :path  => 'invalid/path',
        :line  => 'option=asdf',
        :match => '^option',
      }
    end

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error,/^"invalid\/path" is not an absolute path/)
    end
  end

  describe 'with an invalid type' do
    context 'for the path parameter' do
      let(:params) do
        {
          :path  => ['invalid','type'],
          :line  => 'option=asdf',
          :match => '^option',
        }
      end

      it 'should fail' do
        expect {
          should contain_class('types')
        }.to raise_error(Puppet::Error,/^\["invalid", "type"\] is not an absolute path/)
      end
    end

    context 'for the line parameter' do
      let(:params) do
        {
          :path  => '/tmp/foo',
          :line  => ['invalid','type'],
          :match => '^option',
        }
      end

      it 'should fail' do
        expect {
          should contain_class('types')
        }.to raise_error(Puppet::Error,/^\["invalid", "type"\] is not a string/)
      end
    end

    context 'for the match parameter' do
      let(:params) do
        {
          :path  => '/tmp/foo',
          :line  => 'option=asdf',
          :match => ['invalid','type'],
        }
      end

      it 'should fail' do
        expect {
          should contain_class('types')
        }.to raise_error(Puppet::Error,/^\["invalid", "type"\] is not a string/)
      end
    end
  end
end
