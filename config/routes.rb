Rails.application.routes.draw do
  resources :user_creation
  root 'pages#index'
end
