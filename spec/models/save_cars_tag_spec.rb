require 'rails_helper'

RSpec.describe SaveCarsTag, type: :model do
  describe '新規レビュー登録' do
    before do
      @sct = FactoryBot.build(:save_cars_tag)
    end
    context '新規レビュー登録がうまくいく時' do
      it '全てのフォームに値が存在すれば登録できる' do
        expect(@sct).to be_valid
      end
      it 'genre_idとtitleとtextがあれば登録できる' do
        @sct.images = []
        @sct.maker_id = nil
        @sct.car_name = nil
        @sct.grade = nil
        @sct.body_type_id = nil
        @sct.name = nil
        @sct.new_or_old_id = nil
        @sct.price = nil
        @sct.evaluation_id = nil
        expect(@sct).to be_valid
      end
    end
    context '新規商品登録がうまくいかない時' do
      it 'genre_idが空だと登録できない' do
        @sct.genre_id = nil
        @sct.valid?
        expect(@sct.errors.full_messages).to include("「投稿ジャンル」を入力してください")
      end
      it 'genre_idが1だと登録できない' do
        @sct.genre_id = 1
        @sct.valid?
        expect(@sct.errors.full_messages).to include("「投稿ジャンル」を選択してください")
      end
      it 'titleが空だと登録できない' do
        @sct.title = nil
        @sct.valid?
        expect(@sct.errors.full_messages).to include("「タイトル」を入力してください")
      end
      it 'titleが50字以上だと登録できない' do
        @sct.title = '123456789012345678901234567890123456789012345678901'
        @sct.valid?
        expect(@sct.errors.full_messages).to include('「タイトル」は50字以内で入力してください')
      end
      it 'imagesが10枚以上だと登録できない' do
        @sct.images = ['1.png', '2.png', '3.png', '4.png', '5.png', '6.png', '7.png', '8.png', '9.png', '10.png', '11.png']
        @sct.valid?
        expect(@sct.errors.full_messages).to include('「画像」は10文字以内で入力してください')
      end
      it 'textが空だと登録できない' do
        @sct.text = nil
        @sct.valid?
        expect(@sct.errors.full_messages).to include("「本文」を入力してください")
      end
    end
  end
end
