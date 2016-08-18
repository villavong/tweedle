class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :education
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
