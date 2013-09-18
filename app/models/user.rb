class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :password, 
                  :password_confirmation

  # Callbacks
  before_save { self.email = email.downcase }

  # Validations of the attributes
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}

  # Ensure a secure password
  has_secure_password
  validates :password, length: { minimum: 6 }
end
