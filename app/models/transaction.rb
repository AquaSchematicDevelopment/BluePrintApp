class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :portfolio, as: :buyer
  belongs_to :portfolio, as: :seller
end
