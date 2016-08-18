class AddBoardIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :board_id, :integer
  end
end
