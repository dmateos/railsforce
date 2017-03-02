class GraphsController < ApplicationController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @graphs = Graph.all
    authorize @graphs
    @graphs = policy_scope(Graph)
  end

  def show
    begin
      @graph_config = JSON.parse(@graph.raw_graph_settings)
    rescue JSON::ParserError
      @graph_config = "";
    end

    #parser = SequenceParser.new(@graph.data_sequences, multi: true)
    #@data = parser.parse
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
    if @graph.update(graph_params)
      redirect_to @graph
    else
      render :edit
    end
  end

  def destroy
    @graph.destroy
    redirect_to graphs_path
  end

  private
  def graph_params
    params.require(:graph).permit(:name, :g_type, :description, :tag, :raw_graph_settings)
  end

  def set_graph
    @graph = Graph.find(params[:id])
    authorize @graph
  end
end
