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
        @car.image = nil
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
        expect(@car.errors.full_messages).to include()
      end
      it 'textが空だと登録できない' do
        @car.text = nil
        @car.valid?
        expect(@car.errors.full_messages).to include()
      end
    end
  end
end
