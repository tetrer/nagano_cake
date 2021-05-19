Rails.application.routes.draw do

  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      member do
        resource :order_details, only: [:update]
      end
    end
  end


  get 'addresses/index'
  get 'addresses/create'
  get 'addresses/edit'
  get 'addresses/update'
  get 'addresses/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do
    resource :customers, only: [:update, :quit, :out, :show, :edit]
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :products, only: [:index, :show]
    resources :orders, only: [:new, :index, :create, :show ] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
  end

  delete 'cart_items' => 'public/cart_items#destroy_all'

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
