module SportsDataApi
  module Mlb
    class PlayerSeasonStats
      include Enumerable
      attr_reader :season_id, :season_year
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        @players = []
        @season_id   = xml["season_id"]
        @season_year = xml["season_year"]
        xml.children.each do |player|
          next unless player.is_a? Nokogiri::XML::Element
          @players << PlayerSeasonStat.new(player)
        end
      end

      def [](search_index)
        @players[search_index]
      end

      def each(&block)
        @players.each do |stat|
          if block_given?
            block.call stat
          else
            yield stat
          end
        end
      end
    end
  end
end

