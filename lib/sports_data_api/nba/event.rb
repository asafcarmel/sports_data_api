module SportsDataApi
  module Nba
    
    class Event
      attr_reader :id, :type, :description, :player_id
      
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @type = xml['event_type']
          @description = xml.xpath('description').text
          relevantPlayer = xml.xpath('statistics/*/player')
          @player_id = relevantPlayer.first['id'] unless relevantPlayer.empty?
        end
      end
    end
  end
end