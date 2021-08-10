Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get "organisations/:id/join" => 'organisations#join'
  get "organisations/:id/leave" => 'organisations#leave'

  resources :users, only: :show
  resources :organisations, except: :index do
    resources :shifts, only: [:index, :new, :create]
  end

end
