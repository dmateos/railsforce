class Api::V1::DataSequencesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @graph = Graph.find(params[:id])

    if @graph
      #authorize @graph
      sequences = @graph.data_sequences
      parser = SequenceParser.new(sequences, multi: true)
      render json: parser.parse.to_json and return
    end

    render json: :error
  end

  def create
    @graph = Graph.find(params[:id])

    if @graph
      #authorize @graph

      @data_sequence = DataSequence.create(data_sequence_params)
      @data_sequence.graph = @graph

      #authorize @data_sequence

      if @data_sequence.save
        render json: @data_sequence.id and return
      end
    end

    render json: :error
  end

  private
  def data_sequence_params
    params.require(:data_sequence).permit(:meta, :data, :series)
  end
end
