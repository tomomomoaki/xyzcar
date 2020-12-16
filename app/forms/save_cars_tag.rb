class SaveCarsTag
  include ActiveModel::Model
  attr_accessor :genre_id, :title, :old_ids, :images, :text, :maker_id, :car_name, :grade, :body_type_id, :name, :new_or_old_id, :price, :evaluation_id, :user_id

  with_options presence: true do
    validates :genre_id, numericality: { other_than: 1 , message: 'を選択してください'}
    validates :title, length: { maximum: 50 , message: 'は50字以内で入力してください'}
    validates :text
  end
  validates :images, length: { maximum: 10 }

  # // carがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
  delegate :persisted?, to: :car

  def initialize(attributes = nil, car: Car.new)
    @car = car
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list, old_images)
    ActiveRecord::Base.transaction do
      # // 新しく追加する画像がない場合は、imagesカラムを一旦、空にする
      if images.blank?
        @car.update(images: [])
      else
        @car.update(images: images)
      end
      # // 残す画像と新しく追加する画像を足し合わせて、もう一度保存
      @car.images.each do |image|
        old_images << image
      end
      @car.update(genre_id: genre_id, title: title, images: old_images, text: text, maker_id: maker_id, car_name: car_name, grade: grade, body_type_id: body_type_id, new_or_old_id: new_or_old_id, price: price, evaluation_id: evaluation_id, user_id: user_id)

      # // @carに紐付くタグがあれば、car_tagsテーブルの紐付くレコードを全て消去する
      @car.car_tags.each do |tag|
        tag.delete
      end

      # // tag_listのタグの数だけ、tagsテーブルと、car_tagsテーブルに保存する
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
      genre_id: car.genre_id,
      title: car.title,
      images: car.images,
      text: car.text,
      maker_id: car.maker_id,
      car_name: car.car_name,
      grade: car.grade,
      body_type_id: car.body_type_id,
      name: car.tags.pluck(:name).join(','),
      new_or_old_id: car.new_or_old_id, 
      price: car.price, 
      evaluation_id: car.evaluation_id
    }
  end
end
