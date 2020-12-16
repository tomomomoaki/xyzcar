require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '新規レビュー登録' do
    before do
      @car = FactoryBot.build(:car)
    end
    context '新規レビュー登録がうまくいく時' do
      it '全てのフォームに値が存在すれば登録できる' do
        expect(@car).to be_valid
      end
      it 'ganre_idとtitleとtextがあれば登録できる' do
        @car.images = []
        @car.maker_id = nil
        @car.car_name = nil
        @car.grade = nil
        @car.body_type_id = nil
        @car.new_or_old_id = nil
        @car.price = nil
        @car.evaluation_id = nil
        expect(@car).to be_valid
      end
    end
    context '新規商品登録がうまくいかない時' do
      it 'genre_idが空だと登録できない' do
        @car.genre_id = nil
        @car.valid?
        expect(@car.errors.full_messages).to include("「投稿ジャンル」を入力してください")
      end
      it 'genre_idが1だと登録できない' do
        @car.genre_id = 1
        @car.valid?
        expect(@car.errors.full_messages).to include("「投稿ジャンル」を選択してください")
      end
      it 'titleが空だと登録できない' do
        @car.title = nil
        @car.valid?
        expect(@car.errors.full_messages).to include("「タイトル」を入力してください")
      end
      it 'titleが50字以上だと登録できない' do
        @car.title = '123456789012345678901234567890123456789012345678901'
        @car.valid?
        expect(@car.errors.full_messages).to include('「タイトル」は50字以内で入力してください')
      end
      it 'imagesが10枚以上だと登録できない' do
        @car.images = ['1.png', '2.png', '3.png', '4.png', '5.png', '6.png', '7.png', '8.png', '9.png', '10.png', '11.png']
        @car.valid?
        expect(@car.errors.full_messages).to include('Images is too long (maximum is 10 characters)')
      end
      it 'textが空だと登録できない' do
        @car.text = nil
        @car.valid?
        expect(@car.errors.full_messages).to include("「テキスト」を入力してください")
      end
    end
  end
end
