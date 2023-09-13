Rails.application.routes.draw do
  root 'journals#index'
  resources :user_sessions do; end
  resources :users do; end
  resources :journals do
    resources :journal_entries do
    end
  end
end
