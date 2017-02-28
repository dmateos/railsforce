require "rails_helper"

RSpec.describe "Graphs", type: :request do
  context "authed" do
    let!(:user) { FactoryGirl.create(:user) }

    before :each do
      login(user.email, user.password)
    end

    it "lists all graphs for a given user" do
      get graphs_path
    end

    it "creates a new graph" do

    end

    it "updates an existing graph" do

    end

    it "destroys an existing graph" do

    end

    it "does not destroy another users graph" do

    end

    it "does not update another users graph" do

    end
  end
end
