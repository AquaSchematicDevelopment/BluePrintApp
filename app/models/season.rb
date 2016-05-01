class Season < ActiveRecord::Base
  belongs_to :league
  has_many :teams
  
  def self.statuses
    self.status_options.map {|option| option[1]}
  end
  
  def self.check_valid_status(status)
    self.statuses.find {|obj| obj == status}
  end
  
  def self.status_options
    [
      ['Unpublished', :unpublished], ['Pre IPO', :pre_ipo], ['IPO', :ipo], 
      ['Post IPO', :post_ipo], ['Game Open', :game_open], ['Game Close', :game_closed]
    ]
  end
end
