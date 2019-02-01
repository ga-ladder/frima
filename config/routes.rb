# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :users do
    collection do
      get 'login_way'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products
  resources :categories, only: [:show] do
    collection do
      get 'search'
    end
  end
end
