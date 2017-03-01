class DataSequenceChannel < ApplicationCable::Channel
  def subscribed
    graph = Graph.find(params[:graph])
    graph_str = "Graph_#{graph.id}"
    stream_from graph_str
  end

  def unsubscribed
  end
end
