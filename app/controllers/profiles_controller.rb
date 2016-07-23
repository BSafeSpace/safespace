include ProfilesHelper
class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :fix_json_params

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = build_query  
    @online_only = query_online_only?
    @sort_type = query_sort_type
    @current_characteristics = current_user.profile.characteristics

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
    @current_characteristics = current_user.profile.characteristics

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

      @doneTutFilter = params[:doneTutFilter]
      if @doneTutFilter
        current_user.done_tut_filter = @doneTutFilter
        current_user.save
      end
      gon.doneTutFilter = current_user.done_tut_filter

      @doneTutAddFriend = params[:doneTutAddFriend]
      if @doneTutAddFriend
        current_user.done_tut_add_friend = @doneTutAddFriend
        current_user.save
      end
      gon.doneTutAddFriend = current_user.done_tut_add_friend
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
  end

  # POST /profiles
  # POST /profiles.json
  def create
    parse_answers(params[:answers])
    params[:user_id] = params[:tags][0].to_i
    @user = User.find params[:user_id]
    @profile = @user.profile
    @profile.update(profile_params)

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
      params.require(:profile).permit(:class_rank, :socioeconomic_status, :living_situation, :sexual_orientation, :comfort_with_sexuality, :age, :is_first_generation_college_student, :is_physically_disabled, :is_parent, :is_single_parent, :is_from_foster_care, :is_intercollegiate_athlete, :is_military, :is_out_of_state_student, :is_international_student, :is_transfer_student, :user_id, characteristic_ids:[])
    end
end
