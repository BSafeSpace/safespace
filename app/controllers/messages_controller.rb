class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages

    if @messages.length == 0
      @last_user = nil
    else
      @last_user = @messages[@messages.length-1].user
    end
    
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

    @message = @conversation.messages.new
    @all_friends_sorted = current_user.all_friends_sorted
 
    respond_to do |format|
      format.html { redirect_to conversations_path(@conversation, @message, @messages) }
      format.js
    end

  end

  def new
    @message = @conversation.messages.new
  end

  def create
    respond_to do |format|
      @message = @conversation.messages.new(message_params)
      @conversation.update_time 
      @message.user.try(:touch)
      @messages = @conversation.messages
      @sender = current_user
      @receiver = @conversation.get_other_user(@sender)

      if @messages.length == 0
        @last_user = nil
      else
        @last_user = @messages[@messages.length-2].user
      end

      if @messages.last
        # sender is always the current_user
        if @messages.last.user_id != current_user.id
          @messages.last.read = true;
        else
          # check if message sender is muted; if not then notify receiver
          if !Mute.mute?(@receiver.id, @message.user.id)
            @message.notify_user(@receiver)
          end
        end
      end
      if !@message.save
        flash[:message] = "Message cannot be blank"
      end

      @messages = [@message]

      format.js
      format.html {redirect_to conversation_messages_path(@conversation)}
    end

  end

  def create_peer_message
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    @path = conversation_path(@conversation)
  end

  def get_message_time
    @message = Message.find(params[:message_id])
    @message_time = @message.message_time
    render json: { message_time: @message_time }
  end

private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
