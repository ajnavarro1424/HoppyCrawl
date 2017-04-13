Rails.application.routes.draw do

  resources :brewery_stops

  root 'crawls#landing_page'
  get '/crawls/age_verified' => 'crawls#age_verified'
  get '/admins/index' => 'admins#index'
  put '/admins/:id' => 'admins#update'

  get '/admins/index' => 'admins#index'
  put '/admins/:id' => 'admins#update'

  put '/crawls/:id/make_shareable' => 'crawls#make_shareable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations'}

  post '/crawls/create' => "crawls#create"

	resources :crawls do
	  get 'map_location'
	end

	resources :breweries

end
