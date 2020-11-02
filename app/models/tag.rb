class Tag < ApplicationRecord

  has_many :car_tags, dependent: :destroy
  has_many :cars, through: :car_tags

  validates :name, uniqueness: true

  def self.search(search)
    if search != '#'
      tag = Tag.where('name LIKE(?)',  "%#{search}%")
      tag[0].cars
    else
      Tag.all
    end
  end
end
