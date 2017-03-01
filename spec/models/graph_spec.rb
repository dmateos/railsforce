require 'rails_helper'

RSpec.describe Graph, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:data_sequences) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:g_type) }
  it { should validate_uniqueness_of(:tag) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
end
