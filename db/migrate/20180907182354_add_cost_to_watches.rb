class AddCostToWatches < ActiveRecord::Migration[5.0]
  def change
    add_column :watches, :cost, :string
  end
end
