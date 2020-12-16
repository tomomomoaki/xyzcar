class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :genre_id,      null: false
      t.string :title,      null: false
      t.string :image
      t.text :text,         null: false
      t.string :maker_id
      t.string :car_name
      t.string :grade
      t.string :body_type_id
      t.string :new_or_old_id
      t.integer :price
      t.string :evaluation_id
      t.references :user,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
