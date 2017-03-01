class DataSequencePolicy
    attr_reader :user, :data_sequence

    def initialize(user, data_sequence)
      @user = user
      @data_sequence = data_sequence
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

    def create?
      data_sequence.graph.user == user
    end
end
