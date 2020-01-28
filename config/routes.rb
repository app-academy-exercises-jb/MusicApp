Rails.application.routes.draw do
  
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:index, :new]

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  root to: redirect('/bands/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
