class Micropost < ActiveRecord::Base
  # Rails 4.0 can deduce by itself which attributes are accessible using the
  # data model, so this wouldn't be necessary
  attr_accessible :content, :user_id

  # Association with the User model
  belongs_to :user
  
  # Definition of the scope
  default_scope -> { order('created_at DESC') }

  # Validations over the attributes
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN(#{followed_user_ids}) OR user_id = :user_id", 
           user_id: user)
  end
end
