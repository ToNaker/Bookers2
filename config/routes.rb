Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"

  devise_for :users, controllers: { registrations: "users/registrations" }, path: "", path_names: { sign_out: "sign_out" }


  resources :users, only: [:index, :show, :edit, :update]
  resources :books
end
