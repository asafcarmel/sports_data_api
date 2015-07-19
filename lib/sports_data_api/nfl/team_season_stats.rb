module SportsDataApi
  module Nfl
    class TeamSeasonStats

      attr_reader :id, :players, :touchdowns, :third_down_efficiency, :rushing, :redzone_efficiency, :receiving, :punting, :punt_return, :kick_return,
      :field_goal_return, :penalty, :passing, :kickoffs, :goal_efficiency, :fumbles, :fourth_down_efficiency, :first_downs, :extra_point, :defense,
      :blocked_field_goal_return, :blocked_punt_return, :two_point_conversion, :field_goal ,:statistics
      def initialize(team_hash)
        
        @id     = team_hash["id"]

        @statistics=team_hash
      end
      
      def crteate_new_stat(xml)
        SportsDataApi::Stats.new(xml) unless xml.nil?
      end
    end
  end
end
