class ApplicationController < ActionController::Base

  before_action :authenticate_user!,except: [:top, :about]


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def application
    @book.user_id = current_user.id
    @books = Book.search(params[:search])
  end

  def search
    @book = Book.all
    @books = @book.search(params[:search])
  end



  def after_sign_in_path_for(resource)
      user_path(resource)
  end

end

