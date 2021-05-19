class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    case resource
    when Customer
      root_path
    when Admin
      # 一旦root_path。後から注文履歴一覧(管理者トップページ)へ変更
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    customers_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
             :email, :postal_code, :address, :phone_number])
  end
end
