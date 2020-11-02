class Car < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :maker
  belongs_to_active_hash :body_type

  belongs_to :user
  has_many :car_tags, dependent: :destroy
  has_many :tags, through: :car_tags
  has_many :comments
  mount_uploader :image, ImagesUploader

  def self.search(search)
    if search != nil
      Car.where('title LIKE(?) or text LIKE(?)' , "%#{search}%",  "%#{search}%")
    else
      Car.all
    end
  end

end
