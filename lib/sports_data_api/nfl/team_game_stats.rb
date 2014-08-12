module SportsDataApi
  module Nfl
    class TeamGameStats
      attr_reader :id, :points, :players, :touchdowns, :third_down_efficiency, :rushing, :redzone_efficiency, :receiving, :punting, :punt_return, :penalty,
      :passing, :kickoffs, :goal_efficiency, :fumbles, :fourth_down_efficiency, :first_downs, :extra_point, :defense, :blocked_field_goal_return, :blocked_punt_return
      
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet

        @id     = xml["id"]
        @points = xml["points"]

        @touchdowns = SportsDataApi::Stats.new(xml.xpath("touchdowns").first)
        #@third_down_efficiency = SportsDataApi::Stats.new(xml.xpath("third_down_efficiency").first)
        @rushing = SportsDataApi::Stats.new(xml.xpath("rushing").first)
        #@redzone_efficiency = SportsDataApi::Stats.new(xml.xpath("redzone_efficiency").first)
        @receiving = SportsDataApi::Stats.new(xml.xpath("receiving").first)
        @punting = SportsDataApi::Stats.new(xml.xpath("punting").first)
        @punt_return = SportsDataApi::Stats.new(xml.xpath("punt_return").first)
        @penalty = SportsDataApi::Stats.new(xml.xpath("penalty").first)
        @passing = SportsDataApi::Stats.new(xml.xpath("passing").first)
        @kickoffs = SportsDataApi::Stats.new(xml.xpath("kickoffs").first)
        #@goal_efficiency = SportsDataApi::Stats.new(xml.xpath("goal_efficiency").first)
        @fumbles = SportsDataApi::Stats.new(xml.xpath("fumbles").first)
        #@fourth_down_efficiency = SportsDataApi::Stats.new(xml.xpath("fourth_down_efficiency").first)
        @extra_point = SportsDataApi::Stats.new(xml.xpath("extra_point").first)

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

        xml.xpath("penalty/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.penalty = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("passing/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.passing = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("kickoffs/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.kickoffs = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("fumbles/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.fumbles = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("first_downs/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.first_downs = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("extra_point/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.extra_point = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("defense/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.defense = SportsDataApi::Stats.new(player_xml)
        end

        xml.xpath("blocked_field_goal_return/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.blocked_field_goal_return = SportsDataApi::Stats.new(player_xml)
        end
        
        xml.xpath("blocked_punt_return/player").each do |player_xml|
          player = create_player_stats(players_stats, player_xml["id"])
          player.blocked_punt_return = SportsDataApi::Stats.new(player_xml)
        end
        
        @players = players_stats
      end

      def create_player_stats(players_stats, id)
        if players_stats.include?(id)
          return players_stats[id]
        else
          player = PlayerGameStats.new
          player.id = id
          players_stats[id] = player
        end
      end
    end
  end
end
