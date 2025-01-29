Rails.application.routes.draw do
  devise_for :admins, skip: [ :registrations ]
  devise_for :users
  resources :movies do
    resources :episodes
  end
  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  resources :checkouts, only: [ :create ]

  namespace :admin do
    resources :movies do
      resources :episodes
    end
  end

  get "admin" => "admin#index"

  post "/webhook" => "webhooks#stripe"
  patch "/admin/movies/:movie_id/episodes/:id/move" => "admin/episodes#move"

  # Defines the root path route ("/")
  root "movies#index"
end
