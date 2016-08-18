class AddLanguageToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :language, :string
  end
end
