class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :complications_watches, :complication_quantity, :complication_description
  end
end
