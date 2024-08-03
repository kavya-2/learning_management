Rails.application.routes.draw do
  resources :lessons
  devise_for :admins, skip: [:registrations]
  devise_for :users
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :admin_user do 
    root to: "admin#index", as: :admin_root
  end

  get "admin" => "admin#index"
  # Defines the root path route ("/")
  root "courses#index"
end
