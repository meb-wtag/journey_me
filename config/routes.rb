Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions do; end
  resources :users do
    resources :journals do
      resources :journal_entries do
      end
    end
  end
end
