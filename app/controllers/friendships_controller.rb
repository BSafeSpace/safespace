class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit]
  after_filter { flash.discard if request.xhr? }

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    if !Block.block?(params[:friend_id], current_user.id)
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id], approved: "false")
      @friendship.save
      flash[:notice] = "Friend requested."
    else
      flash[:error] = "Unable to request friendship."
    end
    
    @profiles = build_query  
    @online_only = query_online_only?
    @sort_type = query_sort_type
    
    respond_to do |format|
      format.html { redirect_to profiles_path }
      format.js 
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
    @friendship.update(approved: true)
    if @friendship.save
      flash[:notice] = "Successfully confirmed friend!"
    else
      flash[:notice] = "Sorry! Could not confirm friend!"
    end
    respond_to do |format|
      format.html { redirect_to conversations_path }
      format.js 
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    if params[:block]
      @block = Block.new
      @block.blocker_id = current_user.id
      @block.blocked_id = params[:id]
      @block.save
      @blocked_user = User.find params[:id]
      @blocked_user.blocked_count += 1
      @blocked_user.save
      if @blocked_user.blocked_count >= 3
        @blocked_user.destroy
      end
    end
    flash[:notice] = "Removed friendship."
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :approved)
    end
end
