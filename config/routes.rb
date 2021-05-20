Rails.application.routes.draw do

  root 'public/homes#top'
  get 'about' => 'public/homes#about'

  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :products, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get  'complete'
      end
    end
    resource  :customers, only: [:show, :edit, :update] do
      collection do
        get 'quit'
        patch 'out'
      end
    end
  end

  delete 'cart_items' => 'public/cart_items#destroy_all'

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
