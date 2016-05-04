class User < ActiveRecord::Base
  has_secure_password
  has_many :portfolios

  def is_admin?
    self.role == 'admin'
  end

  def is_player?
    self.role == 'player'
  end
  
  def available_funds
    self.portfolios.inject(self.funds) do |result, portfolio| 
      unless portfolio.buy_requests.empty?
        result -= portfolio.buy_requests.map{|buy_request| buy_request.amount * buy_request.price}.reduce(:+)
      end
      result
    end
  end
  
  def total_portfolio_value
    self.portfolios.select{|portfolio|portfolio.season.in_progress?}.inject(0){|total,portfolio|total + portfolio.total_book_value}
  end
end
