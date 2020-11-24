require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すれば、新規登録ができて、トップページに遷移する' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password（確認用）', with: @user.password_confirmation
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '間違った情報を入力すると、新規登録ができず、新規登録画面に戻る' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'ニックネーム', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password（確認用）', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ユーザーログインができるとき' do
    it '正しい情報を入力すれば、ログインができて、トップページに遷移する' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザーログインができないとき' do
    it '間違った情報を入力すると、ログインができず、新規登録画面に戻る' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq new_user_session_path
    end
  end
end
