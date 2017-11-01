Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'watches#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
end
