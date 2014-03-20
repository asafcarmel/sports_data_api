module SportsDataApi
  module Nba
    class League
      attr_reader :sport, :team_ids

      def initialize(xml)        
        if xml.is_a? Nokogiri::XML::Element          
          @sport = xml['name']
          
          allTeams = xml.xpath("conference").xpath("division").xpath("team")          
          @team_ids = allTeams.map do |team|
            team['id']
          end
          
        end
      end
    
    end
  end
end