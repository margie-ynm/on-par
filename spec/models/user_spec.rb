require 'rails_helper'

RSpec.describe User, type: :model do
    it {should have_many :scorecards}
    it { should have_many :following }
    it { should have_many :followers }
end
