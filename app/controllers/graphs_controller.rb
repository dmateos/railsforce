class GraphsController < ApplicationController
  def index

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def graph_params
    params.require(:graph).permit(:name, :type, :description)
  end
end
