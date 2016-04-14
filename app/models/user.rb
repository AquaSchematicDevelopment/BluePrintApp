class User < ActiveRecord::Base
  has_secure_password
  has_many :portfolios

  def is_admin?
    self.role == 'admin'
  end

  def is_player?
    self.role == 'player'
  end
end
