class AddSpecialtyToSpecialties < ActiveRecord::Migration
  def change
    add_column :specialties, :specialty, :string
  end
end
