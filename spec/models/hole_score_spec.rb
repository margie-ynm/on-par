require 'rails_helper'

describe HoleScore do
  it {should belong_to :scorecard}
  it {should validate_presence_of :number_of_putts}
end
