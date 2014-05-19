Rails.application.routes.draw do

  resources :comics, only: [:index, :new, :show, :create] do
  end

  resources :chapters, only: [:show]

  devise_for :users
  root controller: :comics, action: :index


  authenticate :user do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
