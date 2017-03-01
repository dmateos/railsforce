module Api
  module V1
    class DataSequencesController < ApplicationController
      skip_before_filter :verify_authenticity_token

      def index
        render json: "lol"
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

        render json: "error"
      end

      private
      def data_sequence_params
        params.require(:data_sequence).permit(:meta, :data)
      end
    end
  end
end
