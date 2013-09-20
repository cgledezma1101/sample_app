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
end
