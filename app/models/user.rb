class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  # Active  = accepted friendships
  # Passive = requested you and you accepted.
  has_many :active_friends, -> { where(friendships: { approved: true}) }, :through => :friendships, :source => :friend
  has_many :passive_friends, -> { where(friendships: { approved: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, :through => :passive_friendships, :source => :user
  has_many :conversations
  has_many :messages
  has_many :blocks
  has_one :quiz

  def friends
    active_friends | passive_friends
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :confirmable
         # add :confirmable when ready to email
  validate :berkeley_email
  after_create :create_initial_friendships, :create_initial_profile
  validates_uniqueness_of :username
  attr_accessor :passcode

  has_one :profile

  def requested?(other_user)
    self.requested_friendships.include?(other_user)
  end

  def pending?(other_user)
    self.pending_friends.include?(other_user)
  end

  def friends?(other_user)
    self.friends.include?(other_user)
  end

  def berkeley_email
    if email.present? and not email.match(/.*@berkeley.edu$/)
      errors.add :email, "Must use berkeley.edu email"
    end
  end

  def toggle_appear_offline
    self.appear_offline = !self.appear_offline
    self.save
  end

  def create_initial_profile
    create_profile(user_id: self.id, name: self.username)
  end

  def create_initial_friendships
    self.reload
    self.peer_counselor ||= false
    
    User.where('peer_counselor = ?', !self.peer_counselor).reject{ |u| u == self }.each do |user|
      User.create_friendship(self, user)
    end

    self.save
  end

  def self.peer_counselors
    User.where("peer_counselor = ?", true)
  end

  def self.create_friendship(user1, user2)
    if user1 != user2
      friendship = user1.friendships.build(friend_id: user2.id, approved: "true")
      friendship.save
      user1.save
      user2.save
    end
  end

  def online?
    # if signed in
    if current_sign_in_at.present? 
      online_status = last_sign_out_at.present? ? current_sign_in_at > last_sign_out_at : true
      if (online_status.present?)
      # logger.debug "*****************************"
      # logger.debug "****** #{online_status} ******" 
      # logger.debug " #{self.appear_offline} ******"
      # logger.debug " #{profile.online} ******"
      # logger.debug "*****************************"
        online_status = updated_at > 1.minutes.ago
        if (online_status.present? && self.appear_offline.present? && profile.present?)
          profile.online = online_status && !self.appear_offline
        end
      else
        profile.online = false
      end

      # profile.online = online_status && !self.appear_offline

    else
      if profile.present?
        profile.online = false
      end
    end
    if (profile.present?)
      profile.save
      profile.online
    end
  end

  def block_exists?(user)
    Block.block?(self.id, user.id) if user
  end

  def all_friends
    if self.peer_counselor
      return self.friends.reject{ |f| f.peer_counselor }
    end

    return self.friends
  end

  def all_friends_sorted
    @all_friends = self.all_friends.map{|friend| 
      {:friend => friend, :conversation_time => Conversation.conversation_time(friend.id, self.id)  }
    }
    @all_friends_sorted = @all_friends.sort { |a, b| b[:conversation_time] <=> a[:conversation_time] }
    return @all_friends_sorted
  end

  def non_counselor_friends
    self.friends.select { |friend| friend.peer_counselor == false }
  end

  def online_friends
    self.all_friends.select { |friend| friend.online? }
  end

  def online_status_css
    # puts "hererere"
    # self.online?
    if self.online? && !self.appear_offline
      return "online"
    else
      return "offline"
    end
  end

  def get_characteristics
    self.profile.characteristics
  end

  def get_characteristic_ids
    self.get_characteristics.map { |char| char.id.to_s }
  end

  def notify
    if unread_count.nil?
      update_attributes(:unread_count => 0)
    end
    update_attributes(:unread_count => unread_count + 1)
  end

  def reset_unread
    update_attributes(:unread_count => 0)
  end

  def showcase_reset
    self.signed_liability = false
    self.completed_bio = false
    self.done_tut_filter = false
    self.done_tut_add_friend = false
    self.non_counselor_friends.each do |friend|
      if friend.username != 'Mason Scott'
        @friendship = Friendship.friendship_between(self, friend)
        @friendship.destroy
      end
    end
    self.save
  end

end
