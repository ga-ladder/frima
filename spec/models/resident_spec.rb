require 'rails_helper'

RSpec.describe Resident do
  describe 'create resident' do
    let(:user) { User.create(email:'nic@abc.com', password: '123456', nickname: 'nic') }
    let(:resident) { Resident.new(params)}
    let(:params) { {
      real_first_name: 'nic',
      real_last_name:  'name',
      kana_first_name: 'ニック',
      kana_last_name:  'ナメ',
      birthday:        '2000/12/12',
      zip_code:        '1231234',
      prefecture:      '北海道',
      city_name:       'sample',
      house_number:    '0-1-12',
      user:         user
    } }
    subject { resident }
    context '登録できる resident' do
      it { is_expected.to be_valid }
    end
  end

  describe 'does not create resident' do
    let(:user) { User.create(email:'nic@abc.com', password: '123456', nickname: 'nic') }
    let(:resident) { Resident.new(params)}
    let(:params) { {
      real_first_name: 'nic',
      real_last_name:  'name',
      kana_first_name: 'ニック',
      kana_last_name:  'ナメ',
      birthday:        '2000/12/12',
      zip_code:        '1231234',
      prefecture:      '北海道',
      city_name:       'sample',
      house_number:    '0-1-12',
      user:         user
    } }
    context 'user を持たない resident' do
      it 'has no user_id' do
        resident.user_id = nil
        resident.valid?
        expect(resident.errors.full_messages).to include 'User must exist'
      end
    end
    context '名前(real_name)に異常あり' do
      it 'real_first_name has nil' do
        resident.real_first_name = nil
        resident.valid?
        expect(resident.errors.full_messages).to include "Real first name can't be blank"
      end
      it 'real_last_name has nil' do
        resident.real_last_name = nil
        resident.valid?
        expect(resident.errors.full_messages).to include "Real last name can't be blank"
      end
    end
    context 'kana に異常あり' do
      it 'kana_first_name has nil' do
        resident.kana_first_name = nil
        resident.valid?
        expect(resident.errors.full_messages).to include "Kana first name can't be blank"
      end
      it 'kana_last_name has nil' do
        resident.kana_last_name = nil
        resident.valid?
        expect(resident.errors.full_messages).to include "Kana last name can't be blank"
      end
      it 'kana_first_name is not カタカナ' do
        resident.kana_first_name = 'nic'
        resident.valid?
        expect(resident.errors.full_messages).to include "Kana first name は，カタカナのみが使用できます"
      end
      it 'kana_last_name is not カタカナ' do
        resident.kana_last_name = 'name'
        resident.valid?
        expect(resident.errors.full_messages).to include "Kana last name は，カタカナのみが使用できます"
      end
    end
    describe '郵便番号に異常のある resident' do
      let(:params) { {
        real_first_name: 'nic',
        real_last_name:  'name',
        kana_first_name: 'ニック',
        kana_last_name:  'ナメ',
        birthday:        '2000/12/12',
        zip_code:        zipcode,
        prefecture:      '北海道',
        city_name:       'sample',
        house_number:    '0-1-12',
        user:         user
      } }
      context 'zip_code が nil の resident' do
        let(:zipcode) { nil }
        it 'zip_code is blank' do
          resident.valid?
          expect(resident.errors.full_messages).to include "Zip code can't be blank"
        end
      end
      context 'zip_code が 文字列(数値でない) resident' do
        let(:zipcode) { 'abc' }
        it 'zip_code is not correct' do
          resident.valid?
          expect(resident.errors.full_messages).to include "Zip code is not a number"
        end
      end
      context "zip_code が 7文字でない resident" do
        let(:zipcode) { '123' }
        it 'zip_code is not correct' do
          resident.valid?
          expect(resident.errors.full_messages).to include "Zip code is the wrong length (should be 7 characters)"
        end
      end
    end
    describe '都道府県に異常のある resident' do
      it 'prefecture が nil の resident'
      it 'prefecture が存在しない場所(0以上47以下)である resident'
    end
    describe '市町村に異常のある resident' do
      it 'city_name が nil の resident'
      it 'house_number が nil の resident'
    end
  end
end
