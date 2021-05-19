class ApplicationController < ActionController::Base
    before_action :authenticate_user!,except: [:top]

    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def application
    @book.user_id = current_user.id
  end


  def after_sign_in_path_for(resource)
      user_path(resource)
  end

end

