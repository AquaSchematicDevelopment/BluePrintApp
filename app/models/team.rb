class Team < ActiveRecord::Base
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :transactions
end
