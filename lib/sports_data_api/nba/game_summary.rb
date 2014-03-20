module SportsDataApi
  module Nba
    class GameSummary
      attr_reader :status, :home, :away
      
      class TeamStats < Struct.new(:team_id, :players_stats)
      end
         
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element          
          @status = xml['status']
            
          home_team_id = xml['home_team']
          away_team_id = xml['away_team']
          
          home_team = xml.xpath("team[@id='#{home_team_id}']")
          @home = deserializeTeamNode(home_team.first) unless home_team.empty?
          
          away_team = xml.xpath("team[@id='#{away_team_id}']")      
          @away = deserializeTeamNode(away_team.first) unless away_team.empty?       
          
        end
      end            
      
      def deserializeTeamNode(team)        
        TeamStats.new(team['id'], deserializePlayersNodeSet(team.xpath('players').xpath('player')))
      end
      
      def deserializePlayersNodeSet(players)        
        playersObj = {}                  
        players.map do |player|
          stats_xml = player.xpath('statistics')
          playersObj[player['id']] = Stats.new(stats_xml.first) unless stats_xml.empty?
        end        
        return playersObj
      end
           
    end
  end
end