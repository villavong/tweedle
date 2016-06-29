class RemoveColumnsUsersPaypal < ActiveRecord::Migration
  def change
  	remove_column :users, :paypal_email
  	remove_column :users, :paypal_fname
  	remove_column :users, :paypal_lname
  	remove_column :users, :paypal_verified
  end
end
