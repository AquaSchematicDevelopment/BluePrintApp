class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :buyer
  belongs_to :seller
end
