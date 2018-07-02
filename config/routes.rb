Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

	authenticate :user do

	  root 'watches#index'
	  resources :watches

	  resources :watches do

	  	resource :complications

	  end

	  get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
	  get '/watches/:id/most_maker', to: 'watches#most_maker', as: 'most_maker'

	  get '/watches/:id/newest_watches', to: 'watches#newest_watches', as: 'newest_watches'
	  get 'comlications/:id/description', to: 'complications#description', as: 'description'

	end

end
