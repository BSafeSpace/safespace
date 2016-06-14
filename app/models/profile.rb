class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :characteristics
  validate :set_user_id

  def set_user_id
  	self.user_id = self.id 
  end
end