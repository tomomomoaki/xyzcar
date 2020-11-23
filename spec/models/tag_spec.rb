require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '新規タグ登録' do
    before do
      @tag = FactoryBot.build(:tag)
    end

    context '新規タグ登録がういまくいく時' do
      it 'nameがあれば登録できる' do
        expect(@tag).to be_valid
      end
    end
  end
end
