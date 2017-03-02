class DataSequenceUpdateJob < ApplicationJob
  queue_as :default

  def perform(data_sequence)
    graph = "Graph_#{data_sequence.graph.id}"
    data = SequenceParser.new(data_sequence, single: true).parse
    ActionCable.server.broadcast graph, data
  end
end
