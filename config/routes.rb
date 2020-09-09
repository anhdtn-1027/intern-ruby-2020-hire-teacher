Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    namespace :business do
      get "/home", to: "static_pages#home"
      get "/about", to: "static_pages#about"
      get "/signup", to: "users#new"
      post "/signup", to: "users#create"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      get "next/:id/:day", to: "calendars#next", as: "next"
      get "prev/:id/:day", to: "calendars#prev", as: "prev"

      resources :users, except: %i(new create)
      resources :rooms, only: %i(index show)
      resources :events, except: :new
      resources :rooms do
        resources :reports, only: %i(create destroy)
      end
    end

    namespace :managers do
      root to: "homes#index"
      resources :rooms
      resources :events
      resources :room_actives, only: :update
      resources :users
    end

    namespace :trainers do
      root to: "homes#index"
      resources :update_events
    end
  end
end
