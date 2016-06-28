class Mute < ActiveRecord::Base
	belongs_to :conversation

	def self.mute?(muter_id, muted_id)
  		@mute = Mute.where('muter_id = ? AND muted_id = ?', muter_id, muted_id)
  		return @mute
  	end
end
