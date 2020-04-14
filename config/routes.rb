Rails.application.routes.draw do
  
 root 'home#index'
  
 resources :users, only: [:new, :create, :welcome, :edit, :update]
  
  get 'sessions/new',  to: 'sessions#login'
  post 'sessions/new'
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup', to: 'users#new'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  post 'user', to: 'users#user'
  get 'home/index'


  # this create comments as a nested resource with articles
  resources :articles do
    resources :comments
  end
   
  resources :comments do
    resources :comments
  end
  
  resources :password_resets, only: [:new, :create, :edit, :update]

end
