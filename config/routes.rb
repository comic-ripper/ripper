Rails.application.routes.draw do

  resources :comics, only: [:index, :new, :show] do
  end

  resources :chapters, only: [:show] do
    # resources :pages, only: [:show]
    get ":page_number" => :page
  end

  devise_for :users
  root controller: :static, action: :index


  authenticate :user do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
