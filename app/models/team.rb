class Team < ActiveRecord::Base
  belongs_to :season
  has_many :holdings
  has_many :sell_requests
  has_many :transactions
  
  def safe_name
    return name.split(' ')
      .map { |word| word[0].capitalize + word[1..-1] }
      .join('')
  end
end
