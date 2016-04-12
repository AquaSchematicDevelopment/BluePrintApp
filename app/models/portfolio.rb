class Portfolio < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  has_many :holdings
  has_many :sell_request
  has_many :transactions, as: :seller
  has_many :transactions, as: :buyer
end
