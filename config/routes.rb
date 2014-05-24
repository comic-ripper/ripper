Rails.application.routes.draw do

  devise_for :users
  root controller: :comics, action: :index


  authenticate :user do
    resources :comics, only: [:index, :new, :show, :create] do
      get 'p/:page', action: :index, on: :collection
    end

    resources :chapters, only: [:show] do
      get ':id/:page', action: :show, on: :collection
    end

    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
