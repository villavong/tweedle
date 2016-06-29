class Review < ActiveRecord::Base
  belongs_to :reviser
  belongs_to :user
end
