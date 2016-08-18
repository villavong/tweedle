class AddSchoolemailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :schoolemail, :string
  end
end
