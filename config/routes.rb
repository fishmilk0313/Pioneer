Rails.application.routes.draw do
 
  get 'posts/index'
  get 'posts/show'
  get 'posts/destroy'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :contacts
  root 'homes#top'

  get 'search' => 'searches#find'

  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
  get 'rooms/show'

  devise_for :hosts, controllers: {
    sessions: 'hosts/sessions',
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: "users/passwords",
    registrations: "users/registrations",
  }

  namespace :hosts do
    resources :categories
    resources :topics
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
  end

  namespace :users do
    resources :topics, only: [:index, :show]
    resources :posts
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :notifications, only: [:index, :destroy]
    


    put "/:id/hide" => "users#hide", as: 'users_hide'
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]


  resources :posts, only: [:create, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  scope module: 'users' do
    resources :users, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
