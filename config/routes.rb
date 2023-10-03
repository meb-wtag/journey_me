Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions, only: [:new, :create] do
    delete :logout, to: 'user_sessions#destroy', on: :collection, as: :logout
  end

  resources :users do
    get 'users/confirm_email/:id/:confirm_token', to: 'users#confirm_email', as: 'confirm_email', on: :member
    post :upload_profile_picture, to: 'users#upload_profile_picture', on: :collection
    resources :tasks
    resources :journals do
      resources :journal_entries do
      end
    end
  end
end
