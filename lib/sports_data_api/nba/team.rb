module SportsDataApi
  module Nba
    class Team
      attr_reader :id, :abbr, :name, :market, :players
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element

          @id = xml['id']
          @abbr = xml['alias']
          @name = xml['name']
          @market = xml['market']

          players_xml = xml.xpath('players').xpath('player')
          @players = players_xml.map { |player| Player.new(player) }
        end
      end
    end
  end
end