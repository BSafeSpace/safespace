class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime('%B %-d %Y, %H:%M')
  end
  
  def show_time(last_time)
    if last_time.nil?
      return true
    end
    time_diff = ((created_at - last_time)/60).to_i
    return time_diff >= 30
  end

  def notify_user(user)
    user.notify()
  end
  
end