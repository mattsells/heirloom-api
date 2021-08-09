# frozen_string_literal: true

module V1
  class UsersController < ApiController
    def show
      record = User.find(params[:id])

      authorize record

      render json: ::UserBlueprint.render(record, blueprint_view)
    end
  end
end
