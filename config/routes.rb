Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}
=======
  resources :crawls
  resources :breweries
>>>>>>> 5d349e70d9a5a191c0eebe683edea9265f803620
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
