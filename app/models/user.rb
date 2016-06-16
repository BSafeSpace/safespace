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

  def friends
    active_friends | passive_friends
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable #, :confirmable
         # add :confirmable when ready to email
  validate :berkeley_email
  before_save :create_profile
  validates_uniqueness_of :username

  has_one :profile
  
  def berkeley_email
    if email.present? and not email.match(/.*@berkeley.edu$/)
      errors.add :email, "Must use berkeley.edu email"
    end
  end

  def create_profile
    if profile.nil?
      prof = Profile.create()
      prof.user_id = self.id
      prof.save
    end
  end

  def online?
    if current_sign_in_at.present? 
      online_status = last_sign_out_at.present? ? current_sign_in_at > last_sign_out_at : true
      if (online_status)
        online_status = updated_at > 1.minutes.ago
      end
      online_status
    else
      false
    end
  end

end
