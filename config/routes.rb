Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :universities, only: [ :index, :show ]
      resources :departments,  only: [ :index, :show ]
      resources :degrees,      only: [ :index, :show ]
      resources :courses,      only: [ :index, :show ] do
        collection do
          get :search   # GET /api/v1/courses/search?q=web
        end
      end
      resources :teachers
      resources :students
      resources :enrollments,  only: [ :index ]
      resources :schedules, only: [ :index ]
      resources :terms,   only: [ :index ]
    end
  end
end
