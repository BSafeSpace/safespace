require "prawn"
class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @user = current_user
    @users = User.all
    @conversations = Conversation.where(sender: @user)
    @conversations += Conversation.where(recipient: @user)
    if !@conversations.empty?
      @conversation = Conversation.order("updated_at").last
      @message = @conversation.messages.new
      puts @conversation
      @messages = @conversation.messages
    end
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  def download_chat
    @user = current_user
    @conversation = Conversation.find params[:id]
    send_data generate_pdf(@user, @conversation),
              filename: "#{@conversation.get_other_user(@user).username}_conversation.pdf",
              type: "application/pdf"
  end

private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def generate_pdf(user, conversation)
    Prawn::Document.new do
      text "Your conversation with #{conversation.get_other_user(user).username}", align: :center, :size => 18
      float do
        text "#{conversation.get_other_user(user).username}", align: :left, :size => 14
      end
      text "#{user.username}", align: :right, :size => 14
      pad_bottom(5) { stroke_horizontal_rule }

      conversation.messages.each do |m|
        if m.user_id == user.id
          text "#{m.body}", align: :right
        else 
          text "#{m.body}", align: :left
        end
      end
    end.render
  end

end
