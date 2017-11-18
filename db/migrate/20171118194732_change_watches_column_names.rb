class ChangeWatchesColumnNames < ActiveRecord::Migration[5.0]

  def change
  	rename_column :watches, :name, :watch_name
  	rename_column :watches, :maker, :watch_maker
  end
  
end
