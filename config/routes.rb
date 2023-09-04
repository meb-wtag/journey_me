Rails.application.routes.draw do
  
  root 'journals#index'
  resources :journals do
    resources :journal_entries
  end
end
