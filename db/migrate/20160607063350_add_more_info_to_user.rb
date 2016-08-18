class AddMoreInfoToUser < ActiveRecord::Migration
  def change
  	add_column :users, :fullname, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :description, :text
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :school, :string
    add_column :users, :major, :string
    add_column :users, :school_description, :text
  	add_column :users, :occupation, :string
    add_column :users, :company_name, :string
    add_column :users, :occupation_details, :text
  	add_column :users, :avatar_file_name, :string
  	add_column :users, :avatar_content_type, :string
  	add_column :users, :avatar_file_size, :integer
  	add_column :users, :avatar_updated_at, :datetime
  	add_column :users, :confirmation_token, :string
  	add_column :users, :confirmed_at, :datetime
  	add_column :users, :confirmation_sent_at, :datetime
  	add_index :users, :confirmation_token, unique: true



  end
end
