class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :buyer, :class_name => 'Portfolio', :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => 'Portfolio', :foreign_key => 'seller_id'
end
