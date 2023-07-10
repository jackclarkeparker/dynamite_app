Rails.application.routes.draw do
  resources :regions
  resources :lessons
  resources :venues
  resources :tutors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
