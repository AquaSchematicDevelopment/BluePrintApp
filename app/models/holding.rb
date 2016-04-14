class Holding < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :team
  
  def total_blueprints_currently_being_sold
    sell_requests = SellRequest.where(team: self.team, portfolio: self.portfolio)
    offerings.inject(0) { |total, offering| total + offering.amount }
  end
  
  def available_blueprints
    self.amount - total_blueprints_currently_being_sold
  end
end
