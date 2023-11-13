Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions, only: [:new, :create]
  delete 'user_sessions', to: 'user_sessions#destroy', as: :logout

  resources :users do
    get 'users/confirm_email/:id/:confirm_token', to: 'users#confirm_email', as: 'confirm_email', on: :member
    post :upload_profile_picture, to: 'users#upload_profile_picture', on: :collection
    resources :tasks
    resources :journals do
      get 'calendar', to: 'journals#calendar'
      get 'download', to: 'journals#download', on: :member
      post :upload_file, to: 'journals#upload_file', on: :member
      delete 'delete_file/:file_id', to: 'journals#delete_file', as: :delete_file, on: :member
      resources :journal_entries do
        resources :goals
      end
    end
  end
end


