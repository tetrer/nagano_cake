Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  scope module: :public do
   resources :products, only: [:index, :show]
  end

  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
  end

end
