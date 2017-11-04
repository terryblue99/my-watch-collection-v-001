class AddDescriptionToComplications < ActiveRecord::Migration[5.0]
  def change
    add_column :complications, :description, :string
  end
end
