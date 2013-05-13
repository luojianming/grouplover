#encoding: utf-8
require 'will_paginate/array'
class InvitationsController < ApplicationController
  # GET /invitations
  # GET /invitations.json
  before_filter :authenticate_user!
  before_filter :only_create_one_invitation_one_day, :only => :create
  before_filter :the_group_cannot_be_nil, :only => :create
  def index
    per_page = 100
    @invitations = Invitation.by_location(params[:location]).search(:per_page => per_page) if params[:location]
    if @invitations == nil
      @invitations = Invitation.search(params[:time], :per_page => per_page) if (params[:time] && params[:time].to_s.size != 0 && params[:time].to_s != "时间不限")
    else
      @invitations = @invitations.search(params[:time],:per_page => per_page) if (params[:time]&& params[:time].to_s.size != 0 && params[:time].to_s != "时间不限")
    end
    if @invitations == nil
      @invitations = Invitation.with_member_counts(params[:member_counts].to_i - 1).search(:per_page => per_page) if (params[:member_counts].to_s.size != 0 && params[:member_counts].to_s != "人数不限")
    else
      @invitations = @invitations.with_member_counts(params[:member_counts].to_i - 1).search(:per_page => per_page) if (params[:member_counts].to_s.size != 0 && params[:member_counts].to_s != "人数不限")
    end
    if @invitations == nil
      @invitations = Invitation.by_sex(params[:sex]).search(:per_page => per_page) if (params[:sex] && params[:sex].to_s.size != 0 && params[:sex].to_s != "性别不限")
    else
      @invitations = @invitations.by_sex(params[:sex]).search(:per_page => per_page) if (params[:sex] && params[:sex].to_s.size != 0 && params[:sex].to_s != "性别不限")
    end
    if @invitations == nil
      @invitations = Invitation.by_city(params[:city]).search(:per_page => per_page) if (params[:city] && params[:city].to_s.size != 0 && params[:city].to_s != "全国")
    else
      @invitations = @invitations.by_city(params[:city]).search(:per_page => per_page) if (params[:city] && params[:city].to_s.size != 0 && params[:city].to_s != "全国")
    end
    if @invitations == nil
      @invitations = Invitation.all.paginate(page: params[:page])
    else
      @invitations = @invitations.paginate(page: params[:page])
    end

    respond_to do |format|
      format.html { render 'home/index'}
      format.json { render json: @invitations }
      format.js { render 'index.js' }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end
  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end
=begin
  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end
=end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])

    authorize! :create, @invitation, :message => "对不起，您没有创建邀请贴的权限哦"
    respond_to do |format|
      if @invitation.save
        initiate_group = @invitation.initiate_group
        initiate_group.members.each do |member|
          member.tips.create(:tip_type => "invitation", :content => initiate_group.name + "发布了新的活动")
        end
        format.html { redirect_to my_invitations_user_path(current_user), notice: '邀请贴创建成功.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render 'new' }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end
=begin
  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation = @invitation.destroy

    respond_to do |format|
      format.html { redirect_to my_invitations_user_path(current_user), :notice => "取消活动成功" }
      format.json { head :no_content }
      format.js
    end
  end

  def only_create_one_invitation_one_day
    if Invitation.find_by_initiate_group_id_and_time(params[:invitation][:initiate_group_id],params[:invitation][:time])
      flash[:error] = "该group在当天已经创建过活动了哦"
      redirect_to new_invitation_path
      return false
    end
  end

  def fast_create
    debugger
  end

  def the_group_cannot_be_nil
    if params[:invitation][:initiate_group_id].size == 0
      flash[:error] = "小组不能为空哦,如果还没有已经激活的小组，请先去创建并激活吧"
      redirect_to new_invitation_path
      return false
    end
  end
end
