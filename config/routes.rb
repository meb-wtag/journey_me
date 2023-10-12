Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions, only: [:new, :create]
  delete 'user_sessions', to: 'user_sessions#destroy', as: :logout

  resources :users do
    get 'users/confirm_email/:id/:confirm_token', to: 'users#confirm_email', as: 'confirm_email', on: :member
    post :upload_profile_picture, to: 'users#upload_profile_picture', on: :collection
    resources :tasks
    resources :journals do
      post :upload_file, to: 'users/journals/upload_file', on: :collection
      resources :journal_entries do
      end
    end
  end
end
