Rails.application.routes.draw do
  get 'addresses/index'
  get 'addresses/create'
  get 'addresses/edit'
  get 'addresses/update'
  get 'addresses/destroy'
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do
    resources :customers, only: [:show, :edit, :update, :quit, :out]
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :products, only: [:index, :show]
  end

end
