Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

	authenticate :user do

	  root 'watches#index'
	  resources :watches

	  resources :watches do

	  	resource :complications

	  end

	  get "/sort_watch_names", :to=>"watches#set_sort_watch_names_session"

	  get 'users/:id/delete_user', to: 'users#delete_user', as: 'delete_user'
	  post 'users/:id/delete_user', to: 'users#delete_user'

	  get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
	  get 'watches/:id/most_maker', to: 'watches#most_maker', as: 'most_maker'
	  get 'watches/:id/search_watches', to: 'watches#search_watches', as: 'search_watches'
	  get 'watches/:id/find_maker', to: 'watches#find_maker', as: 'find_maker'

	  get 'watches/:id/newest_watches', to: 'watches#newest_watches', as: 'newest_watches'
	  get 'complications/:id/description', to: 'complications#description', as: 'description'
	  get 'complications/:id/delete_list_comp', to: 'complications#delete_list_comp', as: 'delete_list_comp'
	  post 'complications/:id/delete_list_comp', to: 'complications#delete_list_comp'

	end

end
