module SportsDataApi
  module Nfl
    class PlayerStats
      attr_accessor :id, :games_played, :touchdowns, :rushing, :receiving, :punting, :punt_return, :kick_return, :field_goal_return,
      :penalty, :passing, :kickoffs, :fumbles, :first_downs, :extra_point, :defense, :blocked_field_goal_return,
      :blocked_punt_return, :two_point_conversion, :field_goal
      
      def initialize(player_hash=nil)
        return if player_hash.nil?

        @id = player_hash["id"]
        @games_played = player_hash["games_played"]
        
        player_hash.each_pair do |key,val|
          
          self.instance_variable_set("@#{key}", val)
        end
      end
    end
  end
end
