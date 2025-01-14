Rails.application.routes.draw do
  resources :episodes
  devise_for :admins, skip: [ :registrations ]
  devise_for :users
  resources :movies
  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  get "admin" => "admin#index"

  # Defines the root path route ("/")
  root "movies#index"
end
