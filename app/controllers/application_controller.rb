class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by_id(session[:user_id])
  end

  def redirect_non_user(to: '/')
    redirect_to(to) unless current_user
  end

  def redirect_non_admin(to: '/')
    redirect_to(to) unless current_user.is_admin?
  end

  def redirect_non_player(to: '/')
    redirect_to(to) unless current_user.is_player?
  end
end
