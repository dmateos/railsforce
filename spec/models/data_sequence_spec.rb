require 'rails_helper'

RSpec.describe DataSequence, type: :model do
  it { should belong_to(:graph) }

  it { should validate_presence_of(:graph) }
  it { should validate_presence_of(:data) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
end
