module SportsDataApi
  module Nba
    class Schedule
      attr_reader :id, :year, :games

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::NodeSet
#          @id = xml['id']
#          @year = xml['year']
          @games = xml.map do |game|
            Game.new(game)
          end          
        end
      end
    end
  end
end