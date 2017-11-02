class CreateWatchComplicationJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :watches, :complications do |t|
      t.index [:watch_id, :complication_id]
      # t.index [:complication_id, :watch_id]

      t.integer :complication_quantity

    end
  end
end
