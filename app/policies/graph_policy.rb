class GraphPolicy
  attr_reader :user, :graph
  def initialize(user, graph)
    @user = user
    @graph = graph
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    user
  end

  def show?
    graph.user == user
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    graph.user == user
  end

  def update?
    graph.user == user
  end

  def destroy?
    graph.user == user
  end
end
