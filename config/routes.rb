Rails.application.routes.draw do
  
 resources :users, only: [:new, :create, :welcome]
  
  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  delete 'logout' => 'sessions#destroy'

  post 'user', to: 'users#user'

  get 'user', to: 'users#user'

  get 'home/index'

  # resource method can be used to declare a standart REST resource
  # you need to add the article resource to the config/routes.rb so the file will look as follows
  
  resources :articles do
    # this create comments as a nested resource with articles
    resources :comments
  end
  
  post "searching" => 'home#searching'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
