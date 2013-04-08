#encoding: utf-8
class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  load_resource :user
  load_and_authorize_resource :profile, :through => :user, :singleton => true
  # GET /profiles
  # GET /profiles.json
=begin
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end
=end
  # GET /profiles/1
  # GET /profiles/1.json
  def show
=begin
    @user = User.find(params[:user_id])
    @profile = @user.profile
    authorize! :show, @profile
=end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end
=begin
  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end
=end
  # GET /profiles/1/edit
  def edit
=begin
    @user = User.find(params[:user_id])
    @profile = @user.profile
    authorize! :edit, @profile
=end
  end
=begin
  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.build_profile(params[:profile])
    authorize! :create, @profile

    respond_to do |format|
      if @profile.save
        format.html { redirect_to user_profiles_path(current_user), notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # PUT /purofiles/1
  # PUT /profiles/1.json
  def update
=begin
    @user = User.find(params[:user_id])
    @profile = @user.profile
    authorize! :update, @profile
=end
      @user = User.find(params[:user_id])
      @profile = @user.profile
    if params[:flag] != nil
   #   params[:avatar].content_type = MIME::Types.type_for(params[:avatar].original_filename)[0].to_s
      respond_to do |format|
        if @user.profile.update_attributes(:avatar => params[:avatar])
          format.js { render 'update_avatar' }
        end
      end
    else
      if params[:profile]["style"]
        style_arr = params[:profile]["style"]
        style_str = style_arr[1..style_arr.size].join(',')
        params[:profile]["style"] = style_str
      end
      if params[:profile]["hobby"]
        hobby_arr = params[:profile]["hobby"]
        hobby_str = hobby_arr[1..hobby_arr.size].join(',')
        params[:profile]["hobby"] = hobby_str
      end
      if params[:profile]["lover_style"]
        lover_style_arr = params[:profile]["lover_style"]
        lover_style_str = lover_style_arr[1..lover_style_arr.size].join(',')
        params[:profile]["lover_style"] = lover_style_str
      end
      respond_to do |format|
        if @profile.update_attributes(params[:profile])
          format.html { redirect_to edit_user_profiles_path(current_user), notice: '资料更新成功' }
          format.json { head :no_content }
          format.js { render 'update_avatar' }
        else
          format.html { redirect_to user_path(current_user), notice: '资料更新失败' }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
          format.js { render  'update_avatar' }
        end
      end
    end
  end

  private

=begin
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
=end
end
