class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :transaction, as: :buyer
  belongs_to :transaction, as: :seller
end
