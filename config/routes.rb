Rails.application.routes.draw do
  
  root 'journals#index'
  resources :journals
end
