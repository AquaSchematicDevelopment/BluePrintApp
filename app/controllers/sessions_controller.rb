class SessionsController < ApplicationController
  
  before_action :redirect_non_player, only: [:set_season]
  
  def new
  end

  def create
    user = User.find_by_name(params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:season_id] = nil
      redirect_to root_url
    else
      @errors = ['User Name or Password was incorrect']
      render template: 'sessions/new'
    end
  end
  
  def set_current_season
    session[:season_id] = params[:id]
    redirect_to show_portfolio_path
  end

  def destroy
    session[:season_id = nil]
    session[:user_id] = nil
    redirect_to root_url
  end
end
