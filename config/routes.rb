Rails.application.routes.draw do
  resources :call_logs
  resources :schools
  resources :students
  resources :searches
devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

# or
resources :user, only: [:show]

  resources :principals do
  	member do
  		get :allnab
  	end
  end
  resources :time_clocks
  resources :mnps_reports
  get 'home/index'
  get 'home/timesheets'
  get '/all_mnps_reports/:id', to: 'mnps_reports#all_reports', as: 'all_mnps_reports'
  get '/principals/dlnab/:id', to: 'principals#dlnab', as: 'dlnab'
  get '/principals/dlsnl/:id', to: 'principals#dlsnl', as: 'dlsnl'




  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
