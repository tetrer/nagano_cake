Rails.application.routes.draw do
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
