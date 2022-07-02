Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update]

  get '/home/about' => 'homes#about', as:'about'

  devise_scope :user do
   delete '/users/sign_out' => 'devise/sessions#destroy'
  end
end
