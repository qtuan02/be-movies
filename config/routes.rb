Rails.application.routes.draw do
  root "application#index"
  
  namespace :api do
    namespace :v1 do
      resources :country, only: [ :index, :show, :create, :destroy, :update ]
      resources :genre, only: [ :index, :show, :create, :destroy, :update ]
      resources :movie, only: [ :index, :show, :create, :update ]
      resources :cinema, only: [ :index, :show, :create, :destroy, :update ]
      resources :showtime, only: [ :index, :show, :create, :update ]
      resources :customer, only: [ :index, :show, :create, :update ]
      resources :booking, only: [ :index, :show, :create, :update ]
    end

    namespace :v3 do
      post "/upload/poster", action: :upload_poster, controller: :upload
    end
  end
  
end
