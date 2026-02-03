Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users, only: [:index, :show, :edit, :update] do
    # フォロー/解除：/users/:user_id/relationship
    resource :relationship, only: [:create, :destroy]

    # フォロー一覧/フォロワー一覧：/users/:id/followings, /users/:id/followers
    member do
      get :followings
      get :followers
    end
  end

  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get "search" => "searches#search"
end
