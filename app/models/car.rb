class Car < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :maker
  belongs_to_active_hash :body_type

  belongs_to :user
  has_many :car_tags, dependent: :destroy
  has_many :tags, through: :car_tags
  has_many :comments

  mount_uploaders :images, ImagesUploader
  serialize :images, JSON

  paginates_per 8

  def self.search(search)
    if !search.nil?
      Car.where('title LIKE(?) or text LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Car.all.includes(:user, :tags)
    end
  end

  def self.type(params, cars)
    if (params[:maker_id].to_i >= 2) && (params[:body_type_id].to_i >= 2) && (params[:car_name] != '')
      overlap_cars = cars.where(maker_id: params[:maker_id], body_type_id: params[:body_type_id]).where('car_name LIKE(?)', "%#{params[:car_name]}%")

    elsif (params[:maker_id].to_i >= 2) && (params[:body_type_id].to_i >= 2)
      overlap_cars = cars.where(maker_id: params[:maker_id], body_type_id: params[:body_type_id])

    elsif (params[:maker_id].to_i >= 2) && (params[:car_name] != '')
      overlap_cars = cars.where(maker_id: params[:maker_id]).where('car_name LIKE(?)', "%#{params[:car_name]}%")

    elsif (params[:body_type_id].to_i >= 2) && (params[:car_name] != '')
      overlap_cars = cars.where(body_type_id: params[:body_type_id]).where('car_name LIKE(?)', "%#{params[:car_name]}%")

    elsif params[:maker_id].to_i >= 2
      overlap_cars = cars.where(maker_id: params[:maker_id])

    elsif params[:body_type_id].to_i >= 2
      overlap_cars = cars.where(body_type_id: params[:body_type_id])

    elsif params[:car_name] != ''
      overlap_cars = cars.where('car_name LIKE(?)', "%#{params[:car_name]}%")
    end
    overlap_cars
  end
end
