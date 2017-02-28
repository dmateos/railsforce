module Api
  module V1
    class GraphsController < ApplicationController
      def graph_params
        params.require(:graph).permit(:name, :type, :description)
      end
    end
  end
end
