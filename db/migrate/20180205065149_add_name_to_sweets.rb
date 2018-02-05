class AddNameToSweets < ActiveRecord::Migration[5.0]
  def change
    add_column :sweets, :name, :string
  end
end
