Rails.application.routes.draw do
  resources :crawls
  resources :breweries
  root 'crawls#landing_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
