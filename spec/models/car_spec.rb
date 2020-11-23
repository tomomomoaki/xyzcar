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
      it 'titleとtextがあれば登録できる' do
        @car.images = []
        @car.maker_id = nil
        @car.car_name = nil
        @car.body_type_id = nil
        expect(@car).to be_valid
      end
    end
    context '新規商品登録がうまくいかない時' do
      it 'titleが空だと登録できない' do
        @car.title = nil
        @car.valid?
        expect(@car.errors.full_messages).to include("Title can't be blank")
      end
      it 'titleが50字以上だと登録できない' do
        @car.title = '123456789012345678901234567890123456789012345678901'
        @car.valid?
        expect(@car.errors.full_messages).to include('Title is too long (maximum is 50 characters)')
      end
      it 'imagesが10枚以上だと登録できない' do
        @car.images = ['1.png', '2.png', '3.png', '4.png', '5.png', '6.png', '7.png', '8.png', '9.png', '10.png', '11.png']
        @car.valid?
        expect(@car.errors.full_messages).to include('Images is too long (maximum is 10 characters)')
      end
      it 'textが空だと登録できない' do
        @car.text = nil
        @car.valid?
        expect(@car.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
