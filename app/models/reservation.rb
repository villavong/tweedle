class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviser


  has_attached_file :document
  validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

  validates_attachment_size :document, :less_than => 10.megabytes
  has_attached_file :completed_doc

   validates_attachment :completed_doc, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

  # def download_url(style_name=:original)
  #   document.s3_bucket.objects[document.s3_object(style_name).key].url_for(:read,
  #       :secure => true,
  #       :expires => 24*3600*3,  # 24 hours*3
  #       :response_content_disposition => "attachment; filename='#{document_file_name}'").to_s
  # end


end
