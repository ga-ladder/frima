require 'rails_helper'

RSpec.describe User do
  describe 'create user' do
    let(:user) { User.new(params)}
    let(:params) { { email: 'nic@abc.com', password: '123456', nickname: 'nic' } }
    subject { user }
    context '登録できる user' do
      it { is_expected.to be_valid }
    end
  end
  describe 'does not create user' do
    let(:user) { User.new(params)}
    let(:params) { { email: email, password: password } }
    # subject { user.errors.messages[param][0] }

    context 'email が nil の user' do
      let(:email) { nil }
      let(:password) { '123456' }
      let(:nickname) { 'nic' }
      it 'has not an email' do
        user.valid?
        expect(user.errors.full_messages[0]).to eq "Email can't be blank"
      end
    end
    context 'password が nil の user' do
      let(:email) { 'nic@abc.com' }
      let(:password) { nil }
      let(:nickname) { 'nic' }
      it 'has not an email' do
        user.valid?
        expect(user.errors.full_messages[0]).to eq "Password can't be blank"
      end
    end
    context 'nickname が nil の user' do
      let(:email) { 'nic@abc.com' }
      let(:password) { '123456' }
      let(:nickname) { nil }
      it 'has not an nickname' do
        user.valid?
        expect(user.errors.full_messages[0]).to eq "Nickname can't be blank"
      end
    end
  end
end
