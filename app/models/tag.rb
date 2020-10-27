class Tag < ApplicationRecord

  has_many :car_tags
  has_many :cars, through: :car_tags

  validates :name, uniqueness: true
end
