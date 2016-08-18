class RemoveConfirmationtokenFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, :confirmation_token
    remove_column :users, :confirmation_token, :string
  end
end
