class ChangeComplicationsColumnNames < ActiveRecord::Migration[5.0]

  def change
  	rename_column :complications, :name, :complication_name
  	rename_column :complications, :description, :complication_description
  end

end
