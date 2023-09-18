Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions, only: [:new, :create] 
  delete 'user_sessions', to: 'user_sessions#destroy', as: :logout

  resources :users do
    resources :journals do
      resources :journal_entries do
      end
    end
  end
end
