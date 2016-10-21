class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
  has_many :mutes

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  # helps to retrieve all conversations of the currently logged-in user
  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id, user.id)
  end

  # check if a conversation exists between any given two users 
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

  # Get updated_at of conversation if conversation, else return random 2012 date
  def self.conversation_time(sender_id, recipient_id)
    @conversation = Conversation.between(sender_id, recipient_id).first
    @conversation ? @conversation.updated_at : Time.zone.parse('2012-07-11 21:00')
  end

  def get_chars(user)
    other_user = self.get_other_user(user)
    if other_user.present?
      characteristics = other_user.profile.characteristics 
      return OpenStruct.new(mental_health: characteristics.where('category = ?', "mental_health"), 
                            age: other_user.profile.age, 
                            gender: characteristics.where('category = ?', "gender"), 
                            religion: characteristics.where('category = ?', "religion"), 
                            ethnicity: characteristics.where('category = ?', "ethnicity"),
                            academic_focus: characteristics.where('category = ?', "academic_focus"))
    end
  end
end