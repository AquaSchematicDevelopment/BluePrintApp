class PagesController < ApplicationController
  
  def home
    if current_user
      player_home if current_user.is_player?
      admin_home if current_user.is_admin?
    else
      non_user_home
    end
  end
  
  def test_page
    @output = 'hello'
  end
  
private

  def admin_home
    render template: 'pages/admin_home'
  end
  
  def player_home
    render template: 'pages/player_home'
  end
  
  def non_user_home
    redirect_to login_url
  end
end
