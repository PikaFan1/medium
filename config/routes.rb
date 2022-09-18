Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/intro/edit', to: 'users/registrations#edit_intro', as: 'edit_user_intro'
    post 'users/intro/edit', to: 'users/registrations#update_intro', as: 'update_user_intro'

  end

  resources :stories do
    member do
      post :unpublish
      post :publish
      post :love
    end
    resources :comments, only: [:create]
  end

  get '@:username/:story_id', to: 'pages#show', as: 'story_page'
  get '@:username', to: 'pages#user', as: 'user_page'
  
  resources :pending_stories


  root 'pages#index'


 

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
