module SportsDataApi
  module Nba
    class SeasonalStatistics
      attr_reader :player_records
      class PlayerStats < Struct.new(:total, :avarage)
      end

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          # Player records { playerId : Overall, ... }
          player_records = xml.xpath('player_records').first
          players = player_records.xpath('player')
          @player_records = {}
          players.map do |player|
            @player_records[player['id']] = deserialize_overall_node(player.xpath('overall').first)
          end
        end
      end

      def deserialize_overall_node(overall)
        totals = initialize_stats(overall.xpath('total').first)
        avrages = initialize_stats(overall.xpath('average').first)
        PlayerStats.new(totals, avrages)
      end

      def initialize_stats(xml)
        stats = {}
        if xml.is_a? Nokogiri::XML::Element
          xml.attributes.each do |attr_name, attr_value|
            stats[attr_name.to_sym] = attr_value.value.to_f
          end
        end
        stats
      end
    end
  end
end
