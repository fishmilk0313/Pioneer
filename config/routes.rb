Rails.application.routes.draw do
	root 'homes#top'

	get 'homes/top' => 'homes#top'
	get 'homes/about' => 'homes#about'

	devise_for :hosts, controllers: {
  	sessions: 'hosts/sessions'
  }
  devise_for :users, controllers:{
  	sessions: 'users/sessions',
  	passwords: "users/passwords",
    registrations: "users/registrations"
  }

	namespace :hosts do
		resources :categories
		resources :topics
		resources :users, only: [:index, :show, :edit, :update]
	end

	namespace :users do
 		resources :topics, only: [:index, :show]
 		resources :posts
 	end

 	scope module: 'users' do
 		resources :users, only: [:show, :edit, :update]
 	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
