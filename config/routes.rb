Rails.application.routes.draw do

  get 'reports/show'

  resources :reports, only: [:show, :create]
  resources :call_logs
  resources :schools
  resources :students
  resources :searches
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :user, only: [:show]

  resources :principals
  resources :time_clocks
  resources :image_shares, only: [:new, :create, :show]
  get 'home/index'
  get 'home/timesheets'
  get 'home/statistics', as: '/statistics'
  get '/all_mnps_reports/:id', to: 'mnps_reports#all_reports', as: 'all_mnps_reports'
  get '/principals/dlnab/:id', to: 'principals#dlnab', as: 'dlnab'
  get '/principals/dlsnl/:id', to: 'principals#dlsnl', as: 'dlsnl'
  get '/principals/dlnice/:id', to: 'principals#dlnice', as: 'dlnice'




  root 'time_clocks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
