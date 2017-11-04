Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root 'watches#index'

  resources :watches
  resources :complicationss, only: [:create]

  get 'watches/:id/rows', to: 'watches#rows', as: 'rows'
  
end
