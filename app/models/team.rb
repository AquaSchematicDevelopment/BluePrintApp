class Team < ActiveRecord::Base
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :transactions
  
  def lowest_priced_sell_requests
    self.sell_requests.filter { |sell_request| sell_request.price == self.lowest_price }
  end
  
  def lowest_price
    self.sell_requests.map { |sell_request| sell_request.price }.min
  end
  
end
