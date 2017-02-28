require "rails_helper"

RSpec.describe "Graphs", type: :request do
  context "authed" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_two) { FactoryGirl.create(:user, email: "test2@test.com") }

    let!(:graph_one) { FactoryGirl.create(:graph, user: user, tag: "test-graph-1") }
    let!(:graph_two) { FactoryGirl.create(:graph, user: user_two, tag: "test-graph-2") }

    before :each do
      login(user.email, user.password)
    end

    it "lists all graphs for a given user" do
      get graphs_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("test-graph-1")
      expect(response.body).to_not include("test-graph-2")
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
