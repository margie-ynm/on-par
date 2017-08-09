require 'rails_helper'

describe Scorecard do
  it {should have_many :hole_scores}
end
