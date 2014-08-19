module SportsDataApi
  module Nfl
    class TeamSeasonStats

      attr_reader :id, :players, :touchdowns, :third_down_efficiency, :rushing, :redzone_efficiency, :receiving, :punting, :punt_return, :kick_return,
      :field_goal_return, :penalty, :passing, :kickoffs, :goal_efficiency, :fumbles, :fourth_down_efficiency, :first_downs, :extra_point, :defense,
      :blocked_field_goal_return, :blocked_punt_return, :two_point_conversion, :field_goal
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet

        @id     = xml["id"]

        @touchdowns = crteate_new_stat(xml.xpath("touchdowns").first)
        #@third_down_efficiency = crteate_new_stat(xml.xpath("third_down_efficiency").first)
        @rushing = crteate_new_stat(xml.xpath("rushing").first)
        #@redzone_efficiency = crteate_new_stat(xml.xpath("redzone_efficiency").first)
        @receiving = crteate_new_stat(xml.xpath("receiving").first)
        @punting = crteate_new_stat(xml.xpath("punting").first)
        @punt_return = crteate_new_stat(xml.xpath("punt_return").first)
        @kick_return = crteate_new_stat(xml.xpath("kick_return").first)
        @field_goal_return = crteate_new_stat(xml.xpath("field_goal_return").first)
        #@penalty = crteate_new_stat(xml.xpath("penalty").first)
        @passing = crteate_new_stat(xml.xpath("passing").first)
        #@kickoffs = crteate_new_stat(xml.xpath("kickoffs").first)
        #@goal_efficiency = crteate_new_stat(xml.xpath("goal_efficiency").first)
        @fumbles = crteate_new_stat(xml.xpath("fumbles").first)
        #@fourth_down_efficiency = crteate_new_stat(xml.xpath("fourth_down_efficiency").first)
        @extra_point = crteate_new_stat(xml.xpath("extra_point").first)
        @defense = crteate_new_stat(xml.xpath("defense").first)
        #@blocked_field_goal_return = crteate_new_stat(xml.xpath("blocked_field_goal_return").first)
        #@blocked_punt_return = crteate_new_stat(xml.xpath("blocked_punt_return").first)
        @two_point_conversion = crteate_new_stat(xml.xpath("two_point_conversion").first)
        @field_goal = crteate_new_stat(xml.xpath("field_goal").first)

        players_stats = []

        xml.xpath("players/player").each do |player_xml|
          players_stats << PlayerStats.new(player_xml)
        end

        @players = players_stats
      end
      
      def crteate_new_stat(xml)
        SportsDataApi::Stats.new(xml) unless xml.nil?
      end
    end
  end
end
