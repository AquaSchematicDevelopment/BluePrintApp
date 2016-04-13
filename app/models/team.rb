class Team < ActiveRecord::Base
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :transactions
  
  def lowest_priced_sell_requests
    self.sell_requests.inject([]) do |map, sell_request|
        if map.empty? || map.first.price == sell_request.price
          map[] = sell_request
        elsif sell_request.price < map.first.price
          map = [sell_request]
        else
          map
        end
      end
  end
  
end
