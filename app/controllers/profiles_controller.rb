class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    @profiles = @search.result(distinct: true)
    gon.profiles = @profiles
    # @profiles = Profile.all

    if params[:q] && params[:q][:online_or_all_profiles] == "1"
      @online_only = true
    else
      @online_only = false
    end

    # start tutorial on first sign in
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

    respond_to do |format|
      format.html 
      format.js
    end

  end

  def search
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    @profiles = @search.result(distinct: true)
    gon.profiles = @profiles
    # @profiles = Profile.all

    if params[:q] && params[:q][:online_or_all_profiles] == "1"
      @online_only = true
    else
      @online_only = false
    end

    # start tutorial on first sign in
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

    respond_to do |format|
      format.html { render :template => 'profiles/index' }
      format.js { render :template => 'profiles/index' }
    end
    
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
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
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
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
