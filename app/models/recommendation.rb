class Recommendation < ActiveRecord::Base
	after_initialize :default_values

	def default_values
		self.opened ||= false
	end

	def get_user 
		return User.find self.user_id
	end

	def self.get_unopened 
		return Recommendation.where("opened = ?", false)
	end
end
