class ChangeCostToBeStringInWatches < ActiveRecord::Migration[5.0]
  def change
  	change_column :watches, :cost, :string
  end
end
