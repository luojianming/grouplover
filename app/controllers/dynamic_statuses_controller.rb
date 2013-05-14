class DynamicStatusesController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def show
    @dynamic_status = DynamicStatus.find(params[:id])
  end
end
