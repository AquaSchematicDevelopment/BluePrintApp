class SellRequest < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :team
end
