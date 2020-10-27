class SaveCarsTag

  include ActiveModel::Model
  attr_accessor :title, :image, :text, :maker_id, :car_name, :body_type_id, :name, :user_id


  with_options presence: true do
    validates :title
    validates :text
  end

  def save
    car = Car.create(title: title, image: image, text: text, maker_id: maker_id, car_name: car_name, body_type_id: body_type_id, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    
    CarTag.create(car_id: car.id, tag_id: tag.id)
  end

end