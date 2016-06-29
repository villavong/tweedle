class DeleteDocument < ActiveRecord::Migration
  def change
  	remove_column :reservations, :document 
  	
  end
end
