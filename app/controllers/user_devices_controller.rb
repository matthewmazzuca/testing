class UserDevicesController < InheritedResources::Base

  private

    def user_device_params
      params.require(:user_device).permit()
    end
end

