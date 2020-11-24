require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規ユーザー登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規ユーザー登録がうまくいく時' do
      it '全てのフォームに値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameとemailとpasswordとpassword_confirmationがあれば登録できる' do
        @user.favorite_car = nil
        @user.introduction = nil
        expect(@user).to be_valid
      end
    end
    context '新規ユーザー登録がうまくいかない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複するメールアドレスでは登録できない' do
        another_user = FactoryBot.build(:user)
        @user.save
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空だと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationの値が一致しないと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '111aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
