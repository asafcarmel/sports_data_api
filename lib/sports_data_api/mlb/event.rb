module SportsDataApi
  module Mlb
    class Event
      attr_reader :id, :home_id, :visitor_id, :year, :season, :scheduled, :home_lineup, :visitor_lineup
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        
        @id = xml['id']
        @year = xml['season_year']
        @season = xml['season_type']
        @scheduled = Time.parse(xml.xpath('scheduled_start_time').children.first.to_s)
        @home_id = xml.xpath('home').first['id']
        @visitor_id = xml.xpath('visitor').first['id']

        @visitor_lineup = []
        xml.xpath('game/visitor/lineup/player').each do |lineup|
          @visitor_lineup << LineupPlayer.new(lineup) if lineup.is_a? Nokogiri::XML::Element
        end

        @home_lineup = []
        xml.xpath('game/home/lineup/player').each do |lineup|
          @home_lineup << LineupPlayer.new(lineup) if lineup.is_a? Nokogiri::XML::Element
        end
      end
    end
  end
end
