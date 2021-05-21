class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_genres, if: proc { !admin_signed_in? }

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
             :email, :postal_code, :address, :phone_number])
  end

  def get_genres
    @genres = Genre.all
  end

end
