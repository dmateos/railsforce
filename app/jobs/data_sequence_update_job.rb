class DataSequenceUpdateJob < ApplicationJob
  queue_as :default

  def perform(data_sequence)
    graph = "Graph_#{data_sequence.graph.id}"
    x,y = data_sequence.data.split(",")
    ActionCable.server.broadcast graph, x: x, y: y
  end
end
