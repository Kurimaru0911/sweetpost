class AddPrefectureToSweets < ActiveRecord::Migration[5.0]
  def change
    add_reference :sweets, :prefecture, foreign_key: true
  end
end
