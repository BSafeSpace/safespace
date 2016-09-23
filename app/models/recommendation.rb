class Recommendation < ActiveRecord::Base
	after_initialize :default_values
	after_create :increment_user_count

	def default_values
		self.opened ||= false
	end

	def increment_user_count
		recommend_count = Profile.find(user_id).recommend_count + 1
		Profile.update(self.user_id, recommend_count: recommend_count)
	end

	def get_user 
		return User.find self.user_id
	end

	def self.get_unopened 
		return Recommendation.where("opened = ?", false)
	end

	def self.unopened_count
		return get_unopened.count 
	end
end
