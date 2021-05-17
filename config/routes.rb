Rails.application.routes.draw do
  namespace :public do
   resources :products, only: [:index, :show]
  end
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
