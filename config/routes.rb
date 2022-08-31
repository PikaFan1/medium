Rails.application.routes.draw do
  devise_for :users

  resources :stories do
    member do
      post :unpublish
      post :publish
    end
  end
  resources :pending_stories


  root 'pages#index'


 

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
