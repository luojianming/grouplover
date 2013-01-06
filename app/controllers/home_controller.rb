class HomeController < ApplicationController
  def index
    @invitations = Invitation.all
    @invitations = @invitations.paginate(page: params[:page])
=begin
    respond_to do |format|
      format.html
      format.json { render json: @invitations }
    end
=end
  end
end
