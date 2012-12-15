#encoding: utf-8
class ProfilesController < ApplicationController
  load_and_authorize_resource
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
    @profile = current_user.profile

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
    @profile = current_user.profile ||= current_user.build_profile()
    render "new"
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.build_profile(params[:profile])

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

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to edit_user_profiles_path(current_user), notice: '资料更新成功' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_user_profiles_path(current_user), notice: '资料更新失败' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
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
