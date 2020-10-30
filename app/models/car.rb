class Car < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :maker
  belongs_to_active_hash :body_type

  belongs_to :user
  has_many :car_tags, dependent: :destroy
  has_many :tags, through: :car_tags
  has_one_attached :image
end
