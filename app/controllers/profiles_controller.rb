include ProfilesHelper
require "ask_awesomely"
require 'bio_typeform'
require 'httparty'
require 'will_paginate/array'
class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :update_hours, :destroy]
  before_action :fix_json_params
  before_action :liability_required, except: [:create]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = build_query  
    @online_only = query_online_only?
    @sort_type = query_sort_type

    gon.profiles = @profiles
    setup_tutorial

    respond_to do |format|
      format.html 
      format.js
    end

  end

  def search
    if params[:commit] == "Save Filters"
      @profiles = build_query  
    end
    if params[:commit] == "Friend Finder"
      @profiles = get_all_profiles  
    end   
    @online_only = query_online_only?
    # @all_counselors = query_all_counselors?
    @sort_type = query_sort_type

    gon.profiles = @profiles

    puts @profiles
    
    setup_tutorial

    respond_to do |format|
      format.html { render :template => 'profiles/index' }
      format.js { render :template => 'profiles/index' }
    end
    
  end

  def setup_tutorial
    if user_signed_in?
      @signInCount = current_user.sign_in_count;
      if @signInCount == 1
        gon.firstSignIn = true
      else
        gon.firstSignIn = false
      end

      if (current_user.completed_bio == false)
        create_bio
        current_user.completed_bio = true
      end 
        
      @doneTutFilter = params[:doneTutFilter]
      if @doneTutFilter
        current_user.update(done_tut_filter: @doneTutFilter)
      end
      gon.doneTutFilter = current_user.done_tut_filter

      @doneTutAddFriend = params[:doneTutAddFriend]
      if @doneTutAddFriend
        current_user.update(done_tut_add_friend: @doneTutAddFriend)
      end
      gon.doneTutAddFriend = current_user.done_tut_add_friend
    end
  end

  def create_bio
    gon.completedBio = current_user.completed_bio
    puts gon.completedBio
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    # # prevent other users from editing profile
    # unless current_user.id == @profile.id
    #   flash[:notice] = "You can not access this."
    #   redirect_to root_path
    # end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    if params[:edit_hours] 
      render 'edit_hours'
    end
    # prevent other users from editing profile
    unless current_user.id == @profile.id
      flash[:notice] = "You can not access this."
      redirect_to root_path
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    parse_answers(params[:answers])
    puts params[:answers]
    params[:user_id] = params[:tags][0].to_i
    @user = User.find params[:user_id]
    @profile = @user.profile
    if @profile.present?
      @profile.update(profile_params)
    end
    if (!@user.showcase)
      @user.update(completed_bio: true)
    end
    respond_to do |format|
      format.json { render :show, status: :created, location: @profile }
      # if @profile.save
      #   format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
      #   format.json { render :show, status: :created, location: @profile }
      # else
      #   format.html { render :new }
      #   format.json { render json: @profile.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    puts "update"
    respond_to do |format|
      if @profile.update(profile_params)
        if params[:profile][:counselor_hours]
           redirect_to edit_profile_path(edit_hours: true) and return
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /profiles/default_search
  def default_search
    @user_chars = current_user.get_characteristics
    @char_ids = []

    # puts @user_chars
    
    if (@user_chars.present?)
      @user_chars.each do |char|
        # puts char.id
        @char_ids.push(char.id)
      end
    end
    render json: { char_ids: @char_ids }
  end

  def peer_counselors
    @profiles = Profile.peer_counselor_profiles
    @profiles = @profiles.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /profiles/1/showcase_reset
  def showcase_reset
    current_user.showcase_reset
    redirect_to intro_info_path
  end

  protected

  def fix_json_params
    params[:answers] ||= []
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      puts "here"
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:class_rank, :socioeconomic_status, :living_situation, :sexual_orientation, :comfort_with_sexuality, :age, :is_first_generation_college_student, :is_physically_disabled, :is_parent, :is_single_parent, :is_from_foster_care, :is_intercollegiate_athlete, :is_military, :is_out_of_state_student, :is_international_student, :is_transfer_student, :user_id, :counselor_hours, characteristic_ids:[])
    end
end
