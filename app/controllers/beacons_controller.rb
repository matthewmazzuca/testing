class BeaconsController < InheritedResources::Base

  private

    def beacon_params
      params.require(:beacon).permit()
    end
end

