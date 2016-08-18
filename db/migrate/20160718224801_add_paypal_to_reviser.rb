class AddPaypalToReviser < ActiveRecord::Migration
  def change
    add_column :revisers, :paypal, :string
  end
end
