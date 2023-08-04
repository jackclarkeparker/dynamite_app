Rails.application.routes.draw do
  # LessonMembers routes
  get 'lessons/:lesson_id/lesson_members/new', to: 'lesson_members#new_lesson_member', as: :new_lesson_member
  post 'lessons/:lesson_id/lesson_members', to: 'lesson_members#create_lesson_member', as: :create_lesson_member
  delete 'lessons/:lesson_id/lesson_members/:student_id', to: 'lesson_members#destroy_lesson_member', as: :lesson_member

  # StudentContacts routes
  get '/students/:student_id/contacts/new', to: 'student_contacts#new_contact_relationship', as: :new_contact_relationship
  post '/students/:student_id/contacts', to: 'student_contacts#create_contact_relationship', as: :create_contact_relationship

  get '/students/:student_id/contacts/:contact_id/edit', to: 'student_contacts#edit_contact_relationship', as: :edit_contact_relationship
  patch '/students/:student_id/contacts/:contact_id', to: 'student_contacts#update_contact_relationship', as: :update_contact_relationship

  delete '/students/:student_id/contacts/:contact_id', to: 'student_contacts#destroy_contact_relationship'

  get '/contacts/:contact_id/students/new', to: 'student_contacts#new_student_relationship', as: :new_student_relationship
  post '/contacts/:contact_id/students', to: 'student_contacts#create_student_relationship', as: :create_student_relationship

  get '/contacts/:contact_id/students/:student_id/edit', to: 'student_contacts#edit_student_relationship', as: :edit_student_relationship
  patch '/contacts/:contact_id/students/:student_id', to: 'student_contacts#update_student_relationship', as: :update_student_relationship

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
