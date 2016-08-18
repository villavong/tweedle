class CreateScholarships < ActiveRecord::Migration
  def change
    create_table :scholarships do |t|
      t.string :name
      t.string :amount
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
