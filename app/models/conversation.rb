class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
  has_many :mutes

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id, recipient_id) { where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id) }

  def update_time
  	self.updated_at = Time.now
  	self.save
  end

  def get_other_user(user)
  	if user.id != self.recipient_id
  		return User.find self.recipient_id
  	else
  		return User.find self.sender_id
  	end
  end

  def same_convo?(sender_id, recipient_id)
    return self == Conversation.between(sender_id, recipient_id).first
  end
end