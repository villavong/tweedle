class AddAttachmentPhotoToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :comments, :photo
  end
end
