#encoding: utf-8
require 'will_paginate/array'
class HomeController < ApplicationController
  include ApplicationHelper
  before_filter :store_location!
  def index
=begin
    per_page = 100
    if current_user != nil
      other_sex = (current_user.profile.sex == "男" ? "女" : "男")
      @invitations = Invitation.by_sex(other_sex).search(:per_page => per_page)
    else
      @invitations = Invitation.all
    end
      @invitations = @invitations.paginate(page: params[:page])
=end
      @invitations = Invitation.all.paginate(page: params[:page])

=begin
    respond_to do |format|
      format.html
      format.json { render json: @invitations }
    end
=end
  end

  def store_location!
    store_location
  end
end
