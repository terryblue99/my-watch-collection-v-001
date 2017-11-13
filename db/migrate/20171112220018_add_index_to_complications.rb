class AddIndexToComplications < ActiveRecord::Migration[5.0]
  def change
  	add_index :complications, :name, unique: true
  end
end
