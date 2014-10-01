class DevicesController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @devices = Device.paginate(page: params[:page])
  end

  def show
    @device = Device.find(params[:id])
  end


  private

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
