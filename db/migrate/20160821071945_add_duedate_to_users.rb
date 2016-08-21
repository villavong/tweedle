class AddDuedateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :due_date, :string
  end
end
