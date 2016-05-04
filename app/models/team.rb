class Team < ActiveRecord::Base
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :buy_requests
  has_many :transactions
  
  def lowest_priced_sell_requests
    self.sell_requests.filter { |sell_request| sell_request.price == self.lowest_price }
  end
  
  def lowest_price
    self.sell_requests.map { |sell_request| sell_request.price }.min
  end
  
  def market_price_formated
    self.market_price ? self.market_price : self.book_value
  end
  
  def currently_being_sold?(exclude: nil)
    sell_requests = self.sell_requests
    sell_requests = sell_requests.reject{|sell_request| sell_request.portfolio == exclude} if exclude
    !sell_requests.empty?
  end
  
  def currently_being_bought?(exclude: nil)
    buy_requests = self.buy_requests
    buy_requests = buy_requests.reject{|buy_request| buy_request.portfolio == exclude} if exclude
    !buy_requests.empty?
  end
end
