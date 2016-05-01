class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_season
  helper_method :current_portfolio

  def current_user
    User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def current_season
    if session[:season_id]
      season = Season.find(session[:season_id])
      
      if season
        season
      else
        @errors = ['Season not found.']
        redirect_to root_path
      end
    else
      nil
    end
  end
  
  def current_portfolio
    if current_user && current_user.is_player? && current_season
      portfolio = current_user.portfolios.find_by season: current_season
      if portfolio
        portfolio
      else
        @errors = ['Portfolio not found.']
        redirect_to root_path
      end
    else
      nil
    end
  end

  def redirect_non_user(to: '/')
    redirect_to(to) unless current_user
  end

  def redirect_non_admin(to: '/')
    redirect_to(to) unless current_user && current_user.is_admin?
  end

  def redirect_non_player(to: '/')
    redirect_to(to) unless current_user && current_user.is_player?
  end
  
  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    begin
      Float(string || '')
    rescue ArgumentError
      nil
    end
  end
end
