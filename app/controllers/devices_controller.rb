class DevicesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @devices = Device.where(user_id: @current_user.id).paginate(page: params[:page])
  end

  def show
    @device = Device.find(params[:id])
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])

    if DevicePolicy.new(@current_user, @device).update?

      if @device.update_attributes(device_params)
        flash[:success] = 'Device updated'
        redirect_to @device
      else
        render 'edit'
      end

    else
      flash[:failure] = 'Not authorized.'
      redirect_to devices_path
    end
  end

  def destroy
    @device = Device.find(params[:id])

    if DevicePolicy.new(@current_user, @device).destroy?
      @device.destroy
      flash[:success] = 'Device deleted.'
      redirect_to devices_url

    else
      flash[:failure] = 'Not authorized.'
      redirect_to devices_path
    end
  end

  def aggregate
    Device.aggregate
    redirect_to devices_url
  end

  private

  def device_params
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
