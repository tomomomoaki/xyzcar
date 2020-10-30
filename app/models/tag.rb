class Tag < ApplicationRecord

  has_many :car_tags, dependent: :destroy
  has_many :cars, through: :car_tags

  validates :name, uniqueness: true
end
