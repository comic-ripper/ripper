Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root controller: :comics, action: :index
    
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
