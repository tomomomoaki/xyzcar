require 'rails_helper'

RSpec.describe '新規コメント投稿', type: :system do
  before do
    @car = FactoryBot.create(:car)
    @comment = FactoryBot.build(:comment)
  end
  context '新規コメント投稿ができるとき' do
    it 'ログインしていれば、新規コメント投稿ができて、レビュー詳細ページに遷移する' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car.user.email
      fill_in 'Password', with: @car.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # コメント投稿
      all('.review-links')[0].click
      expect(current_path).to eq "/cars/#{@car.id}"
      fill_in 'comment-text-form', with: @comment.text
      expect  do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(1)
      expect(current_path).to eq "/cars/#{@car.id}"
      expect(page).to have_content(@comment.text.to_s)
    end
  end

  context '新規コメント投稿ができないとき' do
    it 'ログインしていないと、コメントフォームが存在しない' do
      visit root_path
      all('.review-links')[0].click
      expect(current_path).to eq "/cars/#{@car.id}"
      expect(page).to have_no_selector('form[id="comment-form"]')
    end
    it 'textを空欄にすると、コメント投稿ができず、レビュー詳細画面に戻る' do
      # ログイン
      visit new_user_session_path
      fill_in 'Email', with: @car.user.email
      fill_in 'Password', with: @car.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit root_path
      # コメントのtextを空欄で投稿
      all('.review-links')[0].click
      expect(current_path).to eq "/cars/#{@car.id}"
      fill_in 'comment-text-form', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(0)
      expect(current_path).to eq "/cars/#{@car.id}/comments"
    end
  end
end
