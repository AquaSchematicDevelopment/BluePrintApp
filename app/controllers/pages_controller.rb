class PagesController < ApplicationController
  
  def home
    if current_user
      player_home if current_user.is_player?
      admin_home if current_user.is_admin?
      session[:season_id] = nil
    else
      non_user_home
    end
  end
  
  # This used to test functions, mostly library functions
  def test_page
    @output = 'output text'
  end
  
private

  def admin_home
    render template: 'pages/admin_home'
  end
  
  def player_home
    @active_seasons = current_user.portfolios.map{|portfolio| portfolio.season}
    render template: 'pages/player_home'
  end
  
  def non_user_home
    redirect_to login_url
  end
end
