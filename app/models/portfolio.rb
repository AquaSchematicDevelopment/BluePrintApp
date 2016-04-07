class Portfolio < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  has_many :holdings
  has_many :sell_request
end
