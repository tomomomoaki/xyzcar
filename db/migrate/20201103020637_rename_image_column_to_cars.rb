class RenameImageColumnToCars < ActiveRecord::Migration[6.0]
  def change
    rename_column :cars, :image, :images
  end
end
