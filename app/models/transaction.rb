class Transaction < ActiveRecord::Base
  belongs_to :team
  belongs_to :seller, polymorphic: true
  belongs_to :buyer, polymorphic: true
end
