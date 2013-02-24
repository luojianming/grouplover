require 'will_paginate/array'
class InvitationsController < ApplicationController
  # GET /invitations
  # GET /invitations.json
  before_filter :authenticate_user!
  def index
=begin
    @city = params[:city]
    @time = params[:time] || Time.now.strftime('%m-%d')..(Time.now+6*24*3600).strftime('%m-%d')
    @member_counts = params[:member_counts] ||= 1..3
    if @city == nil
      @invitations = Invitation.search(conditions: {time: @time}, with: { group_member_counts: @member_counts})
    else
      @invitations = Invitation.search(conditions: {time: @time, city: @city}, with: { group_member_counts: @member_counts})
    end
=end
    @invitations = Invitation.by_location(params[:location]) if params[:location]
    if @invitations == nil
      @invitations = Invitation.by_time(params[:time]) if params[:time]
    else
      @invitations = @invitations.by_time(params[:time]) if params[:time]
    end
    if @invitations == nil
      @invitations = Invitation.with_member_counts(params[:member_counts].to_i - 1) if params[:member_counts]
    else
      @invitations = @invitations.with_member_counts(params[:member_counts].to_i - 1) if params[:member_counts]
    end
    if @invitations == nil
      @invitations = Invitation.by_city(params[:city]) if params[:city]
    else
      @invitations = @invitations.by_city(params[:city]) if params[:city]
    end
    if @invitations == nil
      @invitations = Invitation.all.paginate(page: params[:page])
    else
      @invitations = @invitations.paginate(page: params[:page])
    end

    respond_to do |format|
      format.html { render 'home/index'}
      format.json { render json: @invitations }
    end
  end

=begin
  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end
=end
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

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
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
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end
end
