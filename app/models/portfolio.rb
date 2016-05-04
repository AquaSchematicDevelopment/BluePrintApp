class Portfolio < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :buy_requests
  has_many :sellers, :class_name => 'Transaction', :foreign_key => 'seller_id'
  has_many :buyers, :class_name => 'Transaction', :foreign_key => 'buyer_id'
  
  def total_book_value
    total = self.holdings.map{|holding| holding.total_book_value}.reduce(:+)
    if total
      total
    else
      0.0
    end
  end
end
