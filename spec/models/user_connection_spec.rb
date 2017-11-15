require 'rails_helper'

describe UserConnection do
  it { should belong_to :follower }
  it { should belong_to :followed }
end
