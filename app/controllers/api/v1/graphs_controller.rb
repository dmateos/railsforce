class Api::V1::GraphsController < ApplicationController
  def graph_params
    params.require(:graph).permit(:name, :type, :description)
  end
end
