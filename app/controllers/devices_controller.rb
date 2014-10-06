class DevicesController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    @devices = Device.paginate(page: params[:page])
  end

  def show
    @device = Device.find(params[:id])
  end

  def edit
  end

  def update
    if @device.update_attributes(user_params)
      flash[:success] = 'Device updated'
      redirect_to @device
    else
      render 'edit'
    end
  end

  def destroy
    Device.find(params[:id]).destroy
    flash[:success] = 'Device deleted.'
    redirect_to devices_url
  end

  private

  def user_params
    params.require(:device).permit(:name, :uuid, :device_type_id)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end
end
