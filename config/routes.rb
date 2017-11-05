Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	
	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

	authenticate :user do  
	  root 'watches#index'
	  resources :watches
	  get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
	end  
  
end
