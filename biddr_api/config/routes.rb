Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resource :session, only: [:create, :destroy]
      get('/current_user', {to: "sessions#current"})
      
      resources :users, only: [:create]

      resources :auctions, only: [:index, :show, :create] do
        resources :bids, only: [:create]
      end

    end

  end
end
