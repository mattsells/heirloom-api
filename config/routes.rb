# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: 'v1/users',
             controllers: {
               registrations: 'v1/registrations'
             }
end
