require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '新規コメント投稿' do
    before do
      @comment = FactoryBot.build(:comment)
    end
    context '新規コメント投稿がうまくいく時' do
      it 'textフォームに値が存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '新規コメント投稿がうまくいかない時' do
      it 'textが空だと登録できない' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
