class League < ActiveRecord::Base
  belongs_to :sport
  has_many :teams
end
