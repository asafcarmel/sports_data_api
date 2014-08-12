module SportsDataApi
  module Nfl
    class PlayerGameStats
      attr_accessor :id, :touchdowns, :rushing, :receiving, :punting, :punt_return, :penalty, :passing, :kickoffs, :fumbles, :first_downs, :extra_point, :defense,
      :blocked_field_goal_return, :blocked_punt_return

      #      def initialize(id)
      #        @id = xml["id"]
      #      end
    end
  end
end
