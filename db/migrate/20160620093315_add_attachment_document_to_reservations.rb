class AddAttachmentDocumentToReservations < ActiveRecord::Migration
  def self.up
    change_table :reservations do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :reservations, :document
  end
end
