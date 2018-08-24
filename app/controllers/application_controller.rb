class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  protected
  

  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :email, :password, :current_password])
  end
  
  # 로그인 이후에 posts/index.html.erb로 가기위한 코드
  def after_sign_in_path_for(resource)
    posts_path
  end
  
end
