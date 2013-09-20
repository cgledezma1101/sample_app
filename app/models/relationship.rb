class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id

  # Relationships with the user table
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # Validations over the attributes
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
