class Board < ActiveRecord::Base
  belongs_to :user

  has_many :comments, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all

end
