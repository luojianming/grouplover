#encoding: utf-8
class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :should_be_related_conversationer, :only => :create
  def index
  end

  def create
    @group = Group.find(params[:group])
  end

  def should_be_related_conversationer
    @group = Group.find(params[:group])
    @related_groups = current_user.related_groups() 
    if !@related_groups.include?(@group)
      redirect_to root_path, :notice => '您无权访问该页'
    end
  end
end
