class AddAttachmentCompletedDocToReservations < ActiveRecord::Migration
  def self.up
    change_table :reservations do |t|
      t.attachment :completed_doc
    end
  end

  def self.down
    remove_attachment :reservations, :completed_doc
  end
end
