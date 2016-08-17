class Content < ActiveRecord::Base
	def as_html(field)
		self.send(field).html_safe
	end
end
