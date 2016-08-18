class Reviser < ActiveRecord::Base
  belongs_to :user

  has_many :reservations
  has_many :reviews

  # validates :description, presence: true, length: {maximum: 500, minimum:10}
  # validates :average_time, presence: true

  # validates :max_pages, presence: true
  # validates :price_per, presence: true
  # validates :paypal, presence: true


  validates :essay_type, uniqueness: { scope: :user_id }

  def average_rating
  	reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end

  def reviser_profit
    self.price_per * self.reservations.count
  end

end
