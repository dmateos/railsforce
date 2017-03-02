require "rails_helper"

describe SequenceParser do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:graph) { FactoryGirl.create(:graph, user: user) }
  let!(:data_sequence) { FactoryGirl.create(:data_sequence, graph: graph) }
  let!(:data_sequence_2) { FactoryGirl.create(:data_sequence, graph: graph) }

  it "loads a sequence into its constructor" do
    parser = SequenceParser.new(data_sequence)
    expect(parser.data_sequence).to eq(data_sequence)
  end

  it "parses a single sequence" do
    parser = SequenceParser.new(data_sequence, single: true)
    expect(parser.parse).to eq({x: "0.0", y: "1.0"})
  end

  it "parses multiple sequences into a set" do
    parser = SequenceParser.new(DataSequence.all, multi: true)
    expect(parser.parse).to eq([{x: "0.0", y: "1.0"}, {x: "0.0", y: "1.0"}])
  end

  it "throws exception if invalid parse option specified" do
    parser = SequenceParser.new(DataSequence.all)
    expect { parser.parse }.to raise_error(SequenceError)
  end

  it "handles a bad sequence" do

  end
end
