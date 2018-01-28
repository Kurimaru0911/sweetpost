class CreateWents < ActiveRecord::Migration[5.0]
  def change
    create_table :wents do |t|
      t.references :user, foreign_key: true
      t.references :sweet, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :sweet_id], unique: true
    end
  end
end
