module SportsDataApi
  module Nba
    class TeamStats
      attr_reader :id, :name, :market, :stats, :players
      
      def initialize(xml, conference = nil, division = nil)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @market = xml['market']
          @players = xml.xpath("player_records/player").map do |player_xml|
            Player.new(player_xml)
          end
        end
      end
    end
  end
end
