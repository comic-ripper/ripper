Rails.application.routes.draw do

  devise_for :users
  root controller: :static, action: :index


  authenticate :user do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
