class SaveCarsTag

  include ActiveModel::Model
  attr_accessor :title, :image, :text, :maker_id, :car_name, :body_type_id, :name, :user_id

  with_options presence: true do
    validates :title, length:{maximum: 40}
    validates :text
  end

  delegate :persisted?, to: :car

  def initialize(attributes = nil, car: Car.new)
    @car = car
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)

    ActiveRecord::Base.transaction do
      @car.update(title: title, image: image, text: text, maker_id: maker_id, car_name: car_name, body_type_id: body_type_id, user_id: user_id)

      @car.car_tags.each do |tag|
        tag.delete
      end

      tag_list.each do |tag_name|
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save

        car_tag = CarTag.where(car_id: @car.id, tag_id: tag.id).first_or_initialize
        car_tag.update(car_id: @car.id, tag_id: tag.id)
      end
    end
  end

  def to_model
    car
  end

  private

  attr_reader :car

  def default_attributes
    {
      title: car.title,
      image: car.image,
      text: car.text,
      maker_id: car.maker_id,
      car_name: car.car_name,
      body_type_id: car.body_type_id,
      name: car.tags.pluck(:name).join(',')
    }
  end

  def split_tag_names
    tag_names.split(',')
  end

end