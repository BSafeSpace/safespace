class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :characteristics
  validate :set_user_id

  def set_user_id
  	self.user_id = self.id 
  end

  def add_characteristic(characteristic)
    self.characteristics << characteristic
  end

  def self.online_or_all_profiles(online)
  	if online
  		return Profile.where('online = ?', true)
  	else
  		return Profile.all
  	end
  end

  def self.ransortable_attributes(auth_object = nil)
  	return ["age", "name", "recommend_count"]
  end

  def self.ransackable_scopes(auth_object = nil)
  	return [:online_or_all_profiles]
  end
end