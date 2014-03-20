module SportsDataApi
  module Nba
    class Stats
      attr_reader :points, :rebounds, :assists, :blocks, :turnovers, :steals
      
      def initialize(xml)                
        if xml.is_a? Nokogiri::XML::Element          
          @points = xml['points'].to_f          
          @rebounds = xml['rebounds'].to_f
          @assists = xml['assists'].to_f
          @blocks = xml['blocks'].to_f
          @turnovers = xml['turnovers'].to_f
          @steals = xml['steals'].to_f
        end
      end
    end
  end
end