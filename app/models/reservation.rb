class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviser


  has_attached_file :document
  # validates_attachment_content_type :document, :content_type => ['application/pdf', 'application/msword', 'text/plain']
  # validates_attachment_size :document, :less_than => 10.megabytes




end
