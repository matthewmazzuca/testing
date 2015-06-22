class HighlightsController < InheritedResources::Base

  private

    def highlight_params
      params.require(:highlight).permit()
    end
end

