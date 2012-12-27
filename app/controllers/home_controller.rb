class HomeController < ApplicationController
  def index
    @invitations = Invitation.all
  end
end
