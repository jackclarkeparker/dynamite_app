Rails.application.routes.draw do
  # StudentContacts routes
  get '/students/:student_id/contacts/new', to: 'student_contacts#new_contact'
  post '/students/:student_id/contacts', to: 'student_contacts#assign_contact'

  get '/students/:student_id/contacts/:contact_id', to: 'student_contacts#edit_contact_relationship'
  patch '/students/:student_id/contacts/:contact_id', to: 'student_contacts#update_contact_relationship'

  get '/contacts/:contact_id/students/new', to: 'student_contacts#new_student'
  post '/contacts/:contact_id/students', to: 'student_contacts#assign_student'

  get '/contacts/:contact_id/students/:student_id', to: 'student_contacts#edit_student_relationship'
  patch '/contacts/:contact_id/students/:student_id', to: 'student_contacts#update_student_relationship'

  resources :contacts
  resources :students
  resources :regions
  resources :lessons
  resources :venues
  resources :tutors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  root 'regions#index'

  get '/lesson_booker', to: 'lessons#booker'

  # Some ideas for routes when implementing the LessonBookerController (Not BookingController)
  # get "/lesson_booker", to: 'lesson_booker#lesson_booker'
  # get "/lesson_booker/:lesson_id/book_now", to: 'lesson_booker#book_now'
  # get "/lesson_booker/:lesson_id/join_waitlist", to: 'lesson_booker#join_waitlist'
end
