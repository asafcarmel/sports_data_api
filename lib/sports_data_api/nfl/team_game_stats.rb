module SportsDataApi
  module Nfl
    class TeamGameStats
      attr_reader :id, :points, :players, :touchdowns, :third_down_efficiency, :rushing, :redzone_efficiency, :receiving, :punting, :punt_return, :kick_return,
        :field_goal_return, :penalty, :passing, :kickoffs, :goal_efficiency, :fumbles, :fourth_down_efficiency, :first_downs, :extra_point, :defense,
        :blocked_field_goal_return, :blocked_punt_return, :two_point_conversion, :field_goal
      
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet

        @id     = xml["id"]
        @points = xml["points"]

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
        
        
        players_stats = {}

        xml.xpath("touchdowns/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.touchdowns = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("rushing/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.rushing = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("receiving/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.receiving = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("punting/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.punting = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("punt_return/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.punt_return = SportsDataApi::Stats.new(player_xml)
        end
        
        xml.xpath("kick_return/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.kick_return = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("field_goal_return/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.field_goal_return = SportsDataApi::Stats.new(player_xml)
        end
        
#        xml.xpath("penalty/player").each do |player_xml|
#          player = create_player_stats(players_stats, player_xml["id"])
#          player.penalty = SportsDataApi::Stats.new(player_xml)
#        end

        xml.xpath("passing/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.passing = SportsDataApi::Stats.new(player_xml)
        end

#        xml.xpath("kickoffs/player").each do |player_xml|
#          player = create_player_stats(players_stats, player_xml["id"])
#          player.kickoffs = SportsDataApi::Stats.new(player_xml)
#        end

        xml.xpath("fumbles/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.fumbles = SportsDataApi::Stats.new(player_xml)
        end

#        xml.xpath("first_downs/player").each do |player_xml|
#          player = create_player_stats(players_stats, player_xml["id"])
#          player.first_downs = SportsDataApi::Stats.new(player_xml)
#        end

        xml.xpath("extra_point/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.extra_point = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("defense/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.defense = SportsDataApi::Stats.new(player_xml)
        end

#        xml.xpath("blocked_field_goal_return/player").each do |player_xml|
#          player = create_player_stats(players_stats, player_xml["id"])
#          player.blocked_field_goal_return = SportsDataApi::Stats.new(player_xml)
#        end
        
#        xml.xpath("blocked_punt_return/player").each do |player_xml|
#          player = create_player_stats(players_stats, player_xml["id"])
#          player.blocked_punt_return = SportsDataApi::Stats.new(player_xml)
#        end
        
        xml.xpath("two_point_conversion/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.two_point_conversion = SportsDataApi::Stats.new(player_xml)
        end
        
        xml.xpath("field_goal/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.field_goal = SportsDataApi::Stats.new(player_xml)
        end
        
        
        @players = players_stats
      end

      def crteate_new_stat(xml)
        SportsDataApi::Stats.new(xml) unless xml.nil?
      end
      
      def create_player_stats(players_stats, id)
        if players_stats.include?(id)
          return players_stats[id]
        else
          player = PlayerStats.new
          player.id = id
          players_stats[id] = player
        end
      end
    end
  end
end
