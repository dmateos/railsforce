require "rails_helper"

RSpec.describe "DataSequence API V1", type: :request do
  let!(:headers) { { "Content-Type" => "application/json", "ACCEPT" => "application/json" } }

  context "authed" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_two) { FactoryGirl.create(:user, email: "test2@test.com") }
    let!(:graph) { FactoryGirl.create(:graph, user: user) }
    let!(:graph_two) { FactoryGirl.create(:graph, user: user_two, tag: "tag2") }

    let!(:data_sequence) { FactoryGirl.create(:data_sequence, graph: graph) }
    let!(:data_sequence_2) { FactoryGirl.create(:data_sequence, graph: graph) }
    let!(:data_sequence_3) { FactoryGirl.create(:data_sequence, graph: graph_two) }

    before :each do
      login(user.email, user.password)  
    end

    it "lists all the sequences for a given graph" do
      get api_v1_data_sequence_path(graph.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("[{\"x\":\"0.0\",\"y\":\"1.0\"},{\"x\":\"0.0\",\"y\":\"1.0\"}]")
    end

    it "creates a new sequence for a given graph" do 
      post api_v1_data_sequences_path,
        params: "{ \"id\": #{graph.id}, \"data_sequence\": { \"data\": 123 } }", headers: headers
      expect(response).to have_http_status(:ok)
      expect(DataSequence.all.size).to eq(4)
    end

    it "does not create a new sequences given someone elses graph" do
      expect {
        post api_v1_data_sequences_path,
          params: "{ \"id\": #{graph_two.id}, \"data_sequence\": { \"data\": 123 } }", headers: headers
      }.to raise_error(Pundit::NotAuthorizedError)

      expect(DataSequence.all.size).to eq(3)
    end
  end
end
