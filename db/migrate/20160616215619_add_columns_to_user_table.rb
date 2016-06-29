class AddColumnsToUserTable < ActiveRecord::Migration
  def change
  	add_column :users, :paypal_email, :string
  	add_column :users, :paypal_fname, :string
  	add_column :users, :paypal_lname, :string
  	add_column :users, :paypal_verified, :boolean
  end
end
