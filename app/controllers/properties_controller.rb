class PropertiesController < InheritedResources::Base

  private

    def property_params
      params.require(:property).permit()
    end
end

