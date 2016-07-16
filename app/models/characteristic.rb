class Characteristic < ActiveRecord::Base
	has_and_belongs_to_many :profiles

	def self.find_name(name)
		Characteristic.where('name = ?', name).first
	end

	def self.find_name_and_category(name, category)
		Characteristic.where("name = ? AND category =?", name, category).first
	end

end
