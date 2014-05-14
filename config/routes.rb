Rails.application.routes.draw do

  root controller: :static, action: :index

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
