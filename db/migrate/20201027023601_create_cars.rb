class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :title,      null: false
      t.text :text,         null: false
      t.string :maker_id,   null: false
      t.string :car_name,   null: false
      t.string :body_type__id,   null: false
      t.references :user,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
