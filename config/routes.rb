Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users, only: [ :index, :show, :edit, :update ]

  resources :books do
    resource :favorite, only: [ :create, :destroy ]
    resources :book_comments, only: [ :create, :destroy ]
  end
end
