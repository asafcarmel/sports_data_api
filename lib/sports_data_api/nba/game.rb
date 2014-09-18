module SportsDataApi
  module Nba
    class Game
      attr_reader :id, :status, :scheduled, :home_team_id, :away_team_id, :home, :away
      
      def initialize(xml)        
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @status = xml['status']
          @scheduled = Time.parse(xml['scheduled'])
          @home = @home_team_id = xml.xpath('home').first['id']
          @away = @away_team_id = xml.xpath('away').first['id']
        end
      end
    end
  end
end