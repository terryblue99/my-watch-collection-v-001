Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	
	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

	authenticate :user do  
	  root 'watches#index'
	  resources :watches
	#   get '/watches/:id/most_maker', to: 'watches#most_maker', as: 'most_maker'
	#   get '/watches/:id/watch_complications', to: 'watches#watch_complications', as: 'watch_complications'
	#   get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
	  resources :watches do

	  	resource :complications, only: [:show, :new, :edit]	    

	  end

	  get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
	  get '/watches/:id/most_maker', to: 'watches#most_maker', as: 'most_maker'
	  get 'comlications/:id/description', to: 'complications#description', as: 'description'

	end 
  
end
