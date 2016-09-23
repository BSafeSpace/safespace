class Friendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :friend, :class_name => "User"

    def self.friendship_between(user, friend)
    	Friendship.where(friend_id: [user, friend]).where(user_id: [user, friend]).last
    end
end
