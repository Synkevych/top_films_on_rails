Rails.application.routes.draw do
  
  root 'home#index'
  
 resources :users, only: [:new, :create, :welcome, :edit, :update]
  
  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  delete 'logout' => 'sessions#destroy'

  post 'user', to: 'users#user'

  get 'user', to: redirect('users#user')

  get 'home/index'


  resources :articles do
    # this create comments as a nested resource with articles
    resources :comments
  end
   
  resources :comments do
    resources :comments
  end
  

end
