class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

#Categories
has_many :revisers, :dependent => :delete_all

accepts_nested_attributes_for :revisers


# #Scope
scope :yes, -> { where(status: nil)}

# scope :yes, -> { where.not(status: nil)}

# scope :active -> language { where("revisers_count != ?", 0)}
# scope :by_specialties -> specialty { where(:specialty => specialty)}
has_many :educations
has_many :works

has_many :languages
has_many :specialties
has_many :scholarships
accepts_nested_attributes_for :educations, reject_if: proc { |attributes| attributes['education'].blank? }, allow_destroy: true
accepts_nested_attributes_for :works, reject_if: proc { |attributes| attributes['work'].blank? }, allow_destroy: true

accepts_nested_attributes_for :scholarships, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
accepts_nested_attributes_for :languages, reject_if: proc { |attributes| attributes['language'].blank? }, allow_destroy: true
accepts_nested_attributes_for :specialties, reject_if: proc { |attributes| attributes['specialty'].blank? }, allow_destroy: true


has_many :posts, :dependent => :delete_all
has_many :comments, :dependent => :delete_all


has_many :reservations, :dependent => :delete_all
has_many :reviews
has_one :verification

has_many :boards, :dependent => :delete_all





# validates :fullname, :presence => true, length: { minimum: 4, maximum: 16 }, :uniqueness => { :case_sensitive => false }
validates :email, :presence => true, length: { minimum: 4, maximum:40 }, :uniqueness => { :case_sensitive => false}





  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :default_url => "/images/:style/missing1.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/



  rails_admin do
  end

  scope :online, lambda{ where("updated_at > ?", 3.minutes.ago) }
  def online?
    updated_at > 3.minutes.ago
  end

  def is_guest_user?
    # Someone is logged in AND (we have a guest id AND that id matches the current user)
    current_user && (session[:guest_user_id] && session[:guest_user_id] == current_user.id)
  end

# Messages


acts_as_messageable

def mailboxer_name
  self.username
end

def mailboxer_email(object)

  self.email

    # or whatever address the email is to be sent to
end


# def mailboxer_email(object)
#   if self.yes_email   # some attribute on the user to indicate they opt out of receiving emails
#     return self.email   # or whatever address the email is to be sent to
#   else
#     nil
#   end
# end



def self.from_omniauth(auth)




    user = User.where(:email => auth.info.email).first


  if user
    return user
  else
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.image = auth.info.image

      user.password = Devise.friendly_token[0,20]
      user.save
    end
  end
end


  def total_payment
    self.reservations.where("status = ?", true).sum(:total)
  end

  def cut_email
    self.schoolemail.gsub(/.{0,4}@/, '****@')
  end

  def country_name
    c = ISO3166::Country[country]
    return c.translations[I18n.locale.to_s] || c.name
  end
end
