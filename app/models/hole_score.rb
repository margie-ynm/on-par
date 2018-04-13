class HoleScore < ActiveRecord::Base
  belongs_to :scorecard
  validates(:number_of_putts, :presence => true )
end
