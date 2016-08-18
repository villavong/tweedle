class AddInstitueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :institute, :string
  end
end
