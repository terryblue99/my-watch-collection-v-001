class AddColumnCurrentWatchIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_watch_id, :integer
  end
end
