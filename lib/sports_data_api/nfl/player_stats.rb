module SportsDataApi
  module Nfl
    class PlayerStats
      attr_accessor :id, :games_played, :touchdowns, :rushing, :receiving, :punting, :punt_return, :kick_return, :field_goal_return,
      :penalty, :passing, :kickoffs, :fumbles, :first_downs, :extra_point, :defense, :blocked_field_goal_return,
      :blocked_punt_return, :two_point_conversion, :field_goal
      
      def initialize(xml=nil)
        return if xml.nil?

        @id = xml["id"]
        @games_played = xml["games_played"]
        
        xml.children.each do |stat|
          next if stat.name == "text"
          self.instance_variable_set("@#{stat.name}", SportsDataApi::Stats.new(stat))
        end
      end
    end
  end
end
