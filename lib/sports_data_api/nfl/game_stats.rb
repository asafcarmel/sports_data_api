module SportsDataApi
  module Nfl
    class GameStats
      attr_reader :id, :status, :home, :away, :teams
      
      def initialize(year, season, week, xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        
        @id     = xml["id"]
        @status = xml["status"]
        @home   = xml["home"]
        @away   = xml["away"]
          
        @teams = []
          
        xml.xpath("team").each do |team_xml|
          teams << TeamGameStats.new(team_xml)
        end
        
#        xml.xpath("player").each do | p |
#          player = {}
#          stats = []
#
#          p.children.each do | stat |
#            if stat.name == "text"
#              next
#            end
#            stats << SportsDataApi::Stats.new(stat)
#          end
#
#          player[:id] = p['id']
#          player[:stats] = stats
#          @players << player
#        end
      end
    end
  end
end
