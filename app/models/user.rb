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
         :recoverable, :rememberable, :trackable, :validatable, :lockable #, :confirmable
         # add :confirmable when ready to email
  validate :berkeley_email
  after_create :create_initial_friendships, :create_initial_profile
  validates_uniqueness_of :username

  has_one :profile

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
    if !peer_counselor
      User.where('peer_counselor = ?', true).each do |user|
        User.create_friendship(self, user)
      end
    else 
      User.where('peer_counselor = ?', false).each do |user|
        User.create_friendship(self, user)
      end
    end
  end

  def self.peer_counselors
    User.where("peer_counselor = ?", true)
  end

  def self.create_friendship(user1, user2)
    friendship = user1.friendships.build(friend_id: user2.id, approved: "true")
    friendship.save
    user1.save
    user2.save
  end

  def online?
    if current_sign_in_at.present? 
      online_status = last_sign_out_at.present? ? current_sign_in_at > last_sign_out_at : true
      if (online_status)
        online_status = updated_at > 1.minutes.ago
      end
      profile.online = online_status && !appear_offline
    else
      profile.online = false
    end
    
    profile.save
    profile.online
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

end
