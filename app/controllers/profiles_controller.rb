include ProfilesHelper
require "ask_awesomely"
require 'bio_typeform'
require 'httparty'
class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :update_hours, :destroy]
  before_filter :fix_json_params
  before_filter :liability_required, except: [:create]

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
    @profiles = build_query  
    @online_only = query_online_only?
    @sort_type = query_sort_type

    gon.profiles = @profiles
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

      create_bio

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

    if !current_user.completed_bio 
      @typeform = BioTypeform.build(current_user)
      @typeform.instance_variable_get(:@structure).instance_variable_get(:@state)[:tags][0] = current_user.id.to_s
      url = 'https://api.typeform.io/latest/forms'
      response = HTTParty.post(url, 
        :body => @typeform.to_json, 
        :headers => { 'Content-Type' => 'application/json', 'X-API-TOKEN' => TYPEFORM_IO_API_KEY } )
      body = JSON.parse(response.body)
      @typeform.instance_variable_set(:@id, body["id"])
      @typeform.instance_variable_set(:@links, body["_links"])
      @typeform.instance_variable_set(:@public_url, body["_links"][1]["href"])
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    parse_answers(params[:answers])
    params[:user_id] = params[:tags][0].to_i
    @user = User.find params[:user_id]
    @profile = @user.profile
    @profile.update(profile_params)
    @user.update(completed_bio: true)

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
    respond_to do |format|
      if @profile.update(profile_params)
        if params[:profile][:counselor_hours]
          format.js
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_hours
    @profile.update(profile_params)
    respond_to do |format|
      format.js
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
    @user_chars.each do |char|
      @char_ids.push(char.id)
    end
    render json: { char_ids: @char_ids }
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
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:class_rank, :socioeconomic_status, :living_situation, :sexual_orientation, :comfort_with_sexuality, :age, :is_first_generation_college_student, :is_physically_disabled, :is_parent, :is_single_parent, :is_from_foster_care, :is_intercollegiate_athlete, :is_military, :is_out_of_state_student, :is_international_student, :is_transfer_student, :user_id, :counselor_hours, characteristic_ids:[])
    end
end
