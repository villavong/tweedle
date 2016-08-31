class AddKakaoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kakao, :string
  end
end
