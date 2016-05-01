class Season < ActiveRecord::Base
  belongs_to :league
  has_many :teams
  
  def self.statuses
    [:unpublished, :pre_ipo, :ipo, :post_ipo, :game_open, :game_closed]
  end
  
  def self.check_valid_status(status)
    self.statuses.find(|obj| obj == status)
  end
  
  def self.status_options
    self.statuses.map {|status| [status, status]}
  end
end
