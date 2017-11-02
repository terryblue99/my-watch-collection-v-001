class CreateWatches < ActiveRecord::Migration[5.0]
  def change
    create_table :watches do |t|
      t.string :name
      t.string :maker
      t.string :movement
      t.string :band
      t.string :model_number
      t.string :water_resistance
      t.string :date_bought
      t.integer :user_id

      t.timestamps
    end
  end
end
