module SportsDataApi
  module Nba
    class PlayByPlay
      attr_reader :home_team_id, :away_team_id, :quarter, :events
      def initialize(xml, events_buffer = 10)
        if xml.is_a? Nokogiri::XML::Element

          # General members
          @home_team_id = xml['home_team']
          @away_team_id = xml['away_team']
          @quarter = xml['quarter']

          # Events array
          lastQuarter = xml.xpath('quarter').last
          allEventsInQuarter = lastQuarter.xpath('events').first
          lastNEvents = allEventsInQuarter.xpath("event[position() > last() - #{events_buffer}]")

          @events = lastNEvents.map do |event|
            Event.new(event)
          end

        end
      end

    end
  end
end