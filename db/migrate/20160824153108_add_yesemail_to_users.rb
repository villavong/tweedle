class AddYesemailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yes_email, :boolean
  end
end
