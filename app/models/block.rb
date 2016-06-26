class Block < ActiveRecord::Base
	belongs_to :blocker, :foreign_key => :blocker_id, class_name: 'User'
  	belongs_to :blocked, :foreign_key => :blocked_id, class_name: 'User'

  	def self.block?(blocker_id, blocked_id)
  		@block = Block.where('blocker_id = ? AND blocked_id = ?', blocker_id, blocked_id)
  		if @block.empty? then false else true end
  	end
end
