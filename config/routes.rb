Rails.application.routes.draw do
 
 root 'homes#top'
  get 'posts/index'
  get 'posts/show'
  get 'posts/destroy'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :contacts

  get 'search' => 'searches#find'

  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'

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
    resources :users, only: [:index, :show, :edit, :update] do 
      member do
        get :contents
      end
    end
    resources :posts, only: [:index, :show, :destroy] do
      member do
        get :contents
      end
    end
  end

  namespace :users do
    resources :categories, only: [:show]
    resources :topics, only: [:index, :show] do
      member do
        get :contents
      end
    end
    resources :posts do 
      member do
        get :contents
      end
    end
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
  resources :rooms, only: [:create, :show, :index, :destroy]


  resources :posts, only: [:create, :destroy] do
    resource :favorites, only: [:create, :destroy, :show]
    resources :comments, only: [:create, :destroy]
  end
  get 'favorites/index'

  scope module: 'users' do
    resources :users, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
