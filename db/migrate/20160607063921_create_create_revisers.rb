class CreateCreateRevisers < ActiveRecord::Migration
  def change
     create_table :revisers do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.integer :max_pages
      t.integer :price_per
      t.boolean :active
      t.string :essay_type
      t.string :average_time
      t.timestamps null: false
    end
  end
end
