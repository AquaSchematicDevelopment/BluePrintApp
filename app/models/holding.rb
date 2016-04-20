class Holding < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :team
  
  def total_blue_prints_currently_being_sold
    sell_requests = SellRequest.where(team: self.team, portfolio: self.portfolio)
    sell_requests.inject(0) { |total, sell_request| total + sell_request.amount }
  end
  
  def available_blue_prints
    self.blue_prints - self.total_blue_prints_currently_being_sold
  end
end
