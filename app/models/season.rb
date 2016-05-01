class Season < ActiveRecord::Base
  belongs_to :league
  has_many :teams
  
  def self.statuses
    self.status_options.map {|option| option[0]}
  end
  
  def self.check_valid_status(status)
    self.statuses.find {|obj| obj == status}
  end
  
  def self.status_options
    [[:unpublished, 'Unpublished'], [:pre_ipo, 'Pre-IPO'], [:ipo, 'IPO'], [:post_ipo, 'Post IPO'], [:game_open, 'Game Open'], [:game_closed, 'Game Close']]
  end
end
