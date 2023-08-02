Rails.application.routes.draw do
  resources :contacts
  resources :students
  resources :regions
  resources :lessons
  resources :venues
  resources :tutors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "regions#index"

  get "/lesson_booker", to: 'lessons#booker'
  get "/students/:id/new_contact", to: 'students#new_contact'
  post "/students/:id/assign_contact", to: 'students#assign_contact'

  # Some ideas for routes when implementing the LessonBookerController (Not BookingController)
  # get "/lesson_booker", to: 'lesson_booker#lesson_booker'
  # get "/lesson_booker/:lesson_id/book_now", to: 'lesson_booker#book_now'
  # get "/lesson_booker/:lesson_id/join_waitlist", to: 'lesson_booker#join_waitlist'
end
