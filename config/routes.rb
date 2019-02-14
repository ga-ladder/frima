# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'phone_registration' => 'users/registrations#phone'
    post 'resident_registration' => 'users/registrations#resident_registration'
    get 'resident_registration' => 'users/registrations#resident'
    post 'customer_registration' => 'users/registrations#customer_registration'
    get 'customer_registration' => 'users/registrations#customer'
    get 'complete' => 'users/registrations#complete'
  end
  resources :users do
    collection do
      get 'sign_up_way'
      get 'logout'
    end
  end
  resources :residents
  resources :customers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products
  resources :categories, only: [:show] do
    collection do
      get 'search'
    end
  end
end
