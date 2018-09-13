class AddCaseMeasurementToWatches < ActiveRecord::Migration[5.0]
  def change
    add_column :watches, :case_measurement, :string
  end
end
