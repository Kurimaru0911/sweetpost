class AddImageToSweets < ActiveRecord::Migration[5.0]
  def change
    add_column :sweets, :image, :string
  end
end
