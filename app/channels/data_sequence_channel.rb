class DataSequenceChannel < ApplicationCable::Channel
  def subscribed
    graph = Graph.find(params[:graph])
    stream_from "Graph_#{graph.id}"
  end

  def unsubscribed
  end
end
