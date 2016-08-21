class AddSharecontactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sharecontact, :boolean
  end
end
