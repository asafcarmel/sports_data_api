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

          allPlayers = xml.xpath('players').xpath('player')
          @players = allPlayers.map do |player|
            Player.new(player)
          end

        end
      end

    end
  end
end