class Reviser < ActiveRecord::Base
  belongs_to :user

  has_many :reservations

  validates :description, presence: true, length: {maximum: 500, minimum:10}
  validates :average_time, presence: true

  validates :essay_type, uniqueness: { scope: :user_id }
  validates :max_pages, presence: true
  validates :price_per, presence: true

end
