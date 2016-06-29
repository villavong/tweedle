class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

has_many :posts, dependent: :destroy
has_many :photos
has_many :comments, dependent: :destroy
has_many :revisers, dependent: :destroy
has_many :reservations
has_many :reviews
has_one :verification

has_many :boards, dependent: :destroy





validates :username, :presence => true, length: { minimum: 4, maximum: 16 }, :uniqueness => { :case_sensitive => false }
validates :email, :presence => true, length: { minimum: 4, maximum:40 }, :uniqueness => { :case_sensitive => false}



  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true




  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :default_url => "/images/:style/missing1.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


# Messages


    acts_as_messageable

    def mailboxer_name
      self.username
    end

    def mailboxer_email(object)
      self.email
    end






def self.from_omniauth(auth)

 anonymous_username = "NewUser#{User.last.id + 1}"


  user = User.where(:email => auth.info.email, :username => anonymous_username).first


  if user
    return user
  else
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.confirmed_at = Time.now
      user.fullname = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = anonymous_username
      user.email = auth.info.email
      user.image = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end
end


  def total_payment
    self.reservations.sum(:total)
  end

  def cut_email
    self.email.gsub(/.{0,4}@/, '****@')
  end

  def country_name
    c = ISO3166::Country[country]
    return c.translations[I18n.locale.to_s] || c.name
  end
end
