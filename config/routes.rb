# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#new'
  resources :user_sessions, only: %i[new create]
  delete 'user_sessions', to: 'user_sessions#destroy', as: :logout

  resources :users do
    post 'upload_profile_picture', to: 'users#upload_profile_picture', on: :collection
    resources :journals do
      resources :journal_entries do
      end
    end
  end
end
