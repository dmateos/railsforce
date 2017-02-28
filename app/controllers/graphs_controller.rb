class GraphsController < ApplicationController
  def index
    @graphs = Graph.all
    authorize @graphs
    @graphs = policy_scope(Graph)
  end

  def show
    @graph = Graph.find(params[:id])
    authorize @graph
  end

  def new
    @graph = Graph.new
    authorize @graph
  end

  def create
    @graph = Graph.new(graph_params)
    authorize @graph

    @graph.user = current_user

    if @graph.save
      redirect_to @graph
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def graph_params
    params.require(:graph).permit(:name, :g_type, :description)
  end
end
