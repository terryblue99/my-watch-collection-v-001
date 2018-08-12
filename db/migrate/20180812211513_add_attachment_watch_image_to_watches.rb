class AddAttachmentWatchImageToWatches < ActiveRecord::Migration[5.0]
  def self.up
    change_table :watches do |t|
      t.attachment :watch_image
    end
  end

  def self.down
    remove_attachment :watches, :watch_image
  end
end
