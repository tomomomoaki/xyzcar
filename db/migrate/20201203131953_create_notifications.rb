class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :car_id
      t.integer :comment_id
      t.integer :send_user_id
      t.integer :transmitted_user_id
      t.boolean :notice,                null: false, default: false
      t.timestamps
    end
  end
end
