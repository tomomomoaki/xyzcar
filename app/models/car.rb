class Car < ApplicationRecord

  belongs_to :user
  has_many :car_tags
  has_many :tags, through: :car_tags
  has_one_attached :image
end
