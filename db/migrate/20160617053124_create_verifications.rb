class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :paypal_email
      t.string :paypal_firstname
      t.string :paypal_lastname
      t.boolean :paypal_verified
      t.timestamps null: false
    end
  end
end
