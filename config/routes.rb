Rails.application.routes.draw do


  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
  end

  get 'addresses/index'
  get 'addresses/create'
  get 'addresses/edit'
  get 'addresses/update'
  get 'addresses/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do
    resources :customers, only: [:show, :edit, :update, :quit, :out]
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :products, only: [:index, :show]
  end

  root 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :admin do
    devise_for :admins, controllers: {
      sessions:      'admin/admins/sessions',
      passwords:     'admin/admins/passwords',
      registrations: 'admin/admins/registrations'
    }
  end

  scope module: :public do
    devise_for :customers, controllers: {
      sessions:      'public/customers/sessions',
      passwords:     'public/customers/passwords',
      registrations: 'public/customers/registrations'
    }

  end

end
