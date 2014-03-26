module SportsDataApi
  module Mlb
    class PlayerSeasonStat
      attr_reader :hitting, :pitching, :player_id
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @player_id = xml["id"]
          @hitting = []
          @pitching = []

          xml.xpath("team/hitting").each do |hitting|
            next unless hitting.is_a? Nokogiri::XML::Element
            @hitting << GameStat.new(hitting)
          end

          xml.xpath("team/pitching").each do |pitching|
            next unless pitching.is_a? Nokogiri::XML::Element
            @pitching << GameStat.new(pitching)
          end
        end
      end
    end
  end
end
