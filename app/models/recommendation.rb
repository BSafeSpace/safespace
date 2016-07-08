class Recommendation < ActiveRecord::Base
	after_initialize :default_values

	def default_values
		self.opened ||= false
	end
end
