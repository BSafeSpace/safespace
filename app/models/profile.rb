class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :characteristics
  validate :set_user_id

  def set_user_id
  	self.user_id = self.id 
  end

  def add_characteristic(characteristic)
    if !self.characteristics.include? characteristic
      self.characteristics << characteristic
    end
  end

  def online_status_css
    if self.user
      self.user.online_status_css
    end
  end

  def self.online_or_all_profiles(online)
  	if online
  		return Profile.where('online = ?', true)
  	else
  		return Profile.all
  	end
  end

  def self.peer_counselor_profiles
    peer_counselor_profiles = []
    User.peer_counselors.each do |counselor|
      peer_counselor_profiles << counselor.profile
    end
    return peer_counselor_profiles
  end

  def format_answer(field)
    answer = self.send(field)
    if !answer
      return ""
    elsif answer == true
      return "Yes"
    end
    answer
  end

  def self.ransortable_attributes(auth_object = nil)
  	return ["age", "name", "recommend_count"]
  end

  def self.ransackable_scopes(auth_object = nil)
  	return [:online_or_all_profiles]
  end
end