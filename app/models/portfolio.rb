class Portfolio < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :buy_requests
  has_many :sellers, :class_name => 'Transaction', :index => 'seller_id'
  has_many :buyers, :class_name => 'Transaction', :index => 'buyer_id'
end
