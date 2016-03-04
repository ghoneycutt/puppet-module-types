require 'spec_helper'

describe 'types::mailalias' do

  context 'mailalias with bare minimum specified' do
    let(:title) { 'user1' }
    let(:params) do
      { :recipient => 'user1@example.com' }
    end
    let(:facts) { { :osfamily => 'RedHat' } }

    it {
      should contain_mailalias('user1').with({
        'ensure'    => 'present',
        'recipient' => 'user1@example.com',
      })
    }
  end

  context 'mailalias with all options specified' do
    let(:title) { 'user1' }
    let(:params) do
      { :ensure    => 'present',
        :provider  => 'aliases',
        :recipient => 'user1@example.com',
        :target    => '/etc/aliases',
      }
    end
    let(:facts) { { :osfamily => 'RedHat' } }

    it {
      should contain_mailalias('user1').with({
        'ensure'    => 'present',
        'provider'  => 'aliases',
        'recipient' => 'user1@example.com',
        'target'    => '/etc/aliases',
      })
    }
  end

  context 'mailalias with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) do
      { :recipient => 'user1@example.com',
        :ensure    => '!invalid',
      }
    end

    it 'should fail' do
      expect {
        should contain_class('types')
      }.to raise_error(Puppet::Error,/types::mailalias::invalid::ensure is invalid and does not match the regex\./)
    end
  end
end
