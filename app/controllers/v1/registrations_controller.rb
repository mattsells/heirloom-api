# frozen_string_literal: true

module V1
  class RegistrationsController < Devise::RegistrationsController
    include Respondable

    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
        else
          expire_data_after_sign_in!
        end

        respond_with resource, status: :created
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
end
