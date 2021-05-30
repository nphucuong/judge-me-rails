require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  resources :reviews, only: [:index, :create] do
  end

  resources :shops, only: [:index] do
    member do
      get :report
    end
  end

  resources :products, only: [:index, :show] do
  end
end
