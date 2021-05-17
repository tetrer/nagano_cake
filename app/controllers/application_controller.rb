class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    if customer_signed_in?
      root_path
    else
      admin_top_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    # マイページへのパス
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
             :email, :postal_code, :address, :phone_number])
  end
end
