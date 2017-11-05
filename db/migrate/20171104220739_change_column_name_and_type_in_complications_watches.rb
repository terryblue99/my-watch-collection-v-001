class ChangeColumnNameAndTypeInComplicationsWatches < ActiveRecord::Migration[5.0]
  def change
  	rename_column :complications_watches, :complication_quantity, :complication_description
  	change_column :complications_watches, :complication_description, :string
  end
end
