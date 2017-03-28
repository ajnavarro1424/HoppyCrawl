Rails.application.routes.draw do

  root 'crawls#landing_page'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users, :controllers => { registrations: 'registrations' }
	# :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}//add this in for twitter/facebook
	resources :crawls
	resources :breweries

end
