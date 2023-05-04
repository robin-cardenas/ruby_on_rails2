Rails.application.routes.draw do
  resources :periods
  resources :payroll_details
  resources :payrolls
  resources :salaries
  resources :employees
  resources :companies

  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  delete '/logout', to: 'users/sessions#destroy'
  get '/search/payrolls', to: 'payrolls#search'
  get '/search/periods', to: 'periods#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'companies#index'
end
