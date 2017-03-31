Rails.application.routes.draw do

  root 'crawls#landing_page'
  get '/crawls/age_verified' => 'crawls#age_verified'

  get '/admins/index' => 'admins#index'
  put '/admins/:id' => 'admins#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users
  post '/crawls/create' => "crawls#create"
	# :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}//add this in for twitter/facebook
	resources :crawls do
	  get 'map_location'
	end

	resources :breweries

end
