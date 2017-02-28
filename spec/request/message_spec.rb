require "rails_helper"

RSpec.describe "Graphs", type: :request do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_two) { FactoryGirl.create(:user, email: "test2@test.com") }

  let!(:graph_one) { FactoryGirl.create(:graph, user: user, tag: "test-graph-1") }
  let!(:graph_two) { FactoryGirl.create(:graph, user: user_two, tag: "test-graph-2") }
  let!(:headers) { { "Content-Type" => "application/json", "ACCEPT" => "application/json" } }

  context "authed" do
    before :each do
      login(user.email, user.password)
    end

    it "lists all graphs for a given user" do
      get graphs_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(graph_one.tag)
      expect(response.body).to_not include(graph_two.tag)
    end

    it "creates a new graph" do
      post graphs_path, params: '{ "graph": { "name": "test-graph-3", "g_type": "test" } }', headers: headers
      expect(response).to have_http_status(:found)
      expect(Graph.all.size).to eq(3)
    end

    it "shows a graph" do
      get graph_path(graph_one.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(graph_one.tag)
    end

    it "updates an existing graph" do

    end

    it "destroys an existing graph" do
      delete graph_path(graph_one.id)
      expect(response).to have_http_status(:found)
      expect(Graph.all.size).to eq(1)
    end

    it "does not show another users graph" do
      expect {
        get graph_path(graph_two.id)
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "does not destroy another users graph" do
      expect {
        delete graph_path(graph_two.id)
      }.to raise_error(Pundit::NotAuthorizedError)
      expect(Graph.all.size).to eq(2)
    end

    it "does not update another users graph" do

    end
  end

  context "unauthed" do
    it "does not allow graphs page to be viewed" do
      expect {
        get graphs_path
      }.to raise_error(Pundit::NotAuthorizedError)
    end
  
    it "does not allow graph page to me viewed" do
      expect {
        get graph_path(graph_one.id)
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "does not allow a graph to be destroyed" do
      expect {
        delete graph_path(graph_two.id)
      }.to raise_error(Pundit::NotAuthorizedError)
      expect(Graph.all.size).to eq(2)
    end
  end
end
