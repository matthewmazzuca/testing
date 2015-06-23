class FieldsController < ApplicationController

  private

    def field_params
      params.require(:field).permit(:name, :value)
    end
end

