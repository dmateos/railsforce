require "rails_helper"

RSpec.describe "DataSequence API V1", type: :request do
  let!(:headers) { { "Content-Type" => "application/json", "ACCEPT" => "application/json" } }

  context "authed" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_two) { FactoryGirl.create(:user, email: "test2@test.com") }
    let!(:graph) { FactoryGirl.create(:graph, user: user) }
    let!(:graph_two) { FactoryGirl.create(:graph, user: user_two, tag: "tag2") }

    before :each do
      login(user.email, user.password)  
    end

    it "lists all the sequences for a given graph" do
      get api_v1_data_sequences_path
    end

    it "creates a new sequence for a given graph" do 
      post api_v1_data_sequences_path,
        params: "{ \"id\": #{graph.id}, \"data_sequence\": { \"data\": 123 } }", headers: headers
      expect(response).to have_http_status(:ok)
      expect(DataSequence.all.size).to eq(1)
    end

    it "does not create a new sequences given someone elses graph" do
      expect {
        post api_v1_data_sequences_path,
          params: "{ \"id\": #{graph_two.id}, \"data_sequence\": { \"data\": 123 } }", headers: headers
      }.to raise_error(Pundit::NotAuthorizedError)

      expect(DataSequence.all.size).to eq(0)
    end
  end
end
