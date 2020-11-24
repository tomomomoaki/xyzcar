require 'rails_helper'

RSpec.describe '新規レビュー投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @sct = FactoryBot.build(:save_cars_tag)
  end
  context '新規レビュー投稿がうまくいくとき' do
    it 'ログインしたユーザーが、正しい情報が入力すれば、レビューが保存され、トップページに遷移する' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # レビュー投稿
      expect(page).to have_content('レビューを投稿する')
      find('a[id="new-review-btn"]').click
      expect(current_path).to eq '/cars/new'
      fill_in 'タイトル（最大50字まで）', with: @sct.title
      fill_in '本文', with: @sct.text
      expect  do
        find('input[name="commit"]').click
      end.to change { Car.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content(@sct.title)
      expect(page).to have_content(@sct.text)
    end
  end

  context '新規レビュー投稿がうまくいかないとき' do
    it 'ログインしていないユーザーは、新規レビュー投稿画面に遷移しようとすると、ログイン画面に遷移する' do
      visit new_car_path
      expect(current_path).to eq new_user_session_path
    end
    it 'ログインしたユーザーが、間違った情報が入力すると、レビューが保存されずに、レビュー投稿画面に戻る' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # レビュー投稿
      expect(page).to have_content('レビューを投稿する')
      find('a[id="new-review-btn"]').click
      expect(current_path).to eq '/cars/new'
      fill_in 'タイトル（最大50字まで）', with: ''
      fill_in '本文', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { Car.count }.by(0)
      expect(current_path).to eq '/cars'
    end
  end
end

RSpec.describe 'レビュー編集', type: :system do
  before do
    @car1 = FactoryBot.create(:car)
    @car2 = FactoryBot.create(:car)
  end
  context 'レビュー編集ができるとき' do
    it 'ログインしたユーザーは自分のレビューを編集できる' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car1.user.email
      fill_in 'Password', with: @car1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # レビュー編集
      all('.review-links')[2].click
      expect(current_path).to eq "/cars/#{@car1.id}"
      expect(page).to have_content('編集')
      find('a[id="car-edit-btn"]').click
      expect(current_path).to eq "/cars/#{@car1.id}/edit"
      expect(
        find('#title').value
      ).to eq @car1.title
      expect(
        find('#text').value
      ).to eq @car1.text
      fill_in 'タイトル（最大50字まで）', with: "#{@car1.title}+編集タイトル"
      fill_in '本文', with: "#{@car1.text}+編集テキスト"
      expect  do
        find('input[name="commit"]').click
      end.to change { Car.count }.by(0)
      expect(current_path).to eq "/cars/#{@car1.id}"
      expect(page).to have_content(@car1.title.to_s)
      expect(page).to have_content(@car1.text.to_s)
    end
  end

  context 'レビュー編集がうまくいかないとき' do
    it '自分の投稿したレビュー以外の、レビュー編集画面に遷移しようとすると、トップページに遷移する' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car1.user.email
      fill_in 'Password', with: @car1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # 自分の投稿したレビュー以外の、レビュー編集画面に遷移しようとする
      visit edit_car_path(@car2)
      expect(current_path).to eq root_path
    end
    it 'ログインしていないユーザーが、レビュー編集画面に遷移しようとすると、ログイン画面に遷移する' do
      # 自分の投稿したレビューの、レビュー編集画面に遷移しようとする
      visit edit_car_path(@car1)
      expect(current_path).to eq new_user_session_path
    end
    it 'ログインしたユーザーが、間違った情報が入力すると、レビューが保存されずに、レビュー投稿画面に戻る' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car1.user.email
      fill_in 'Password', with: @car1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # レビュー編集
      all('.review-links')[2].click
      expect(current_path).to eq "/cars/#{@car1.id}"
      expect(page).to have_content('編集')
      find('a[id="car-edit-btn"]').click
      expect(current_path).to eq "/cars/#{@car1.id}/edit"
      expect(
        find('#title').value
      ).to eq @car1.title
      expect(
        find('#text').value
      ).to eq @car1.text
      fill_in 'タイトル（最大50字まで）', with: ''
      fill_in '本文', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { Car.count }.by(0)
      expect(current_path).to eq "/cars/#{@car1.id}"
    end
  end
end

RSpec.describe 'レビュー削除', type: :system do
  before do
    @car1 = FactoryBot.create(:car)
    @car2 = FactoryBot.create(:car)
  end
  context 'レビュー削除ができるとき' do
    it 'ログインしたユーザーは自分のレビューを削除できる' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car1.user.email
      fill_in 'Password', with: @car1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビュー削除
      all('.review-links')[2].click
      expect(current_path).to eq "/cars/#{@car1.id}"
      expect(page).to have_content('削除')
      expect do
        find('a[id="car-delete-btn"]').click
      end.to change { Car.count }.by(-1)
      expect(current_path).to eq root_path
      expect(page).to have_no_content(@car1.title.to_s)
      expect(page).to have_no_content(@car1.text.to_s)
    end
  end

  context 'レビュー削除ができないとき' do
    it 'ログインしていなければ、削除ボタンがない' do
      visit car_path(@car1)
      expect(page).to have_no_content('削除')
    end
    it 'ログインした状態でも、自分のレビュー以外は削除ボタンがない' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car1.user.email
      fill_in 'Password', with: @car1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 他の人のレビューに削除ボタンがない
      all('.review-links')[0].click
      expect(current_path).to eq "/cars/#{@car2.id}"
      expect(page).to have_no_content('削除')
    end
  end
end
