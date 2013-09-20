class User < ActiveRecord::Base
  # Rails 4.0 can deduce by itself which attributes are accessible using the
  # data model, so this wouldn't be necessary  
  attr_accessible :email, 
                  :name, 
                  :password_digest, 
                  :password, 
                  :password_confirmation,
                  :admin

  # Association with the Micropost model
  has_many :microposts, dependent: :destroy

  # Callbacks
  before_save { email.downcase! }
  before_create :create_remember_token

  # Validations of the attributes
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}

  # Ensure a secure password
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1::hexdigest(token.to_s)
  end

  def feed
    Micropost.where("user_id = ?", id)
  end
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
