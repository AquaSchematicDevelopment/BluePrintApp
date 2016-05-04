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
      ['Unpublished', :unpublished], ['IPO', :ipo], ['Season In Progress', :season_in_progress], ['Season Concluded', :season_concluded]
    ]
  end
  
  def formatted_status
    if self.status
      option = Season.status_options.find{|option| option[1].to_s == self.status}
      option[0]
    else
      nil
    end
  end
end
