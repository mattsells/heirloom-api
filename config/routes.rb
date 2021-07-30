# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    scope :v1 do
      post '/users/sign_up', to: 'v1/registrations#create', as: :v1_user_registration
      post '/users/sign_in', to: 'v1/sessions#create', as: :v1_user_session
    end
  end
end
