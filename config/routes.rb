# frozen_string_literal: true

Rails.application.routes.draw do
  mount ImageUploader.upload_endpoint(:cache) => '/images/upload'
  mount VideoUploader.upload_endpoint(:cache) => '/videos/upload'

  # Set up user mapping but do not add any routes as these will be declared manually for
  # multiple namespace usage
  devise_for :user, only: %w[]

  # Set default response type to ensure flash messages are not set
  defaults format: :json do
    scope :v1 do
      devise_scope :user do
        post '/users/sign_up', to: 'v1/registrations#create', as: :v1_user_registration
        post '/users/sign_in', to: 'v1/sessions#create',      as: :v1_user_session
      end
    end

    namespace :v1 do
      resources :account_users, only: :index
      resources :recipes, :stories
      resources :users, only: :show
    end
  end
end
