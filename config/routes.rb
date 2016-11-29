Rails.application.routes.draw do
  root "application#home"
  resources :books
  resources :categories
end
