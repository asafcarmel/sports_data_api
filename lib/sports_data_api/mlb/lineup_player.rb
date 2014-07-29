module SportsDataApi
  module Mlb
    class LineupPlayer
      attr_reader :id, :inning, :bo, :position, :inning_half
      def initialize(xml)
        @id = xml['id']
        @inning = xml['inning'].to_i
        @bo = xml['bo'].to_i
        @position = xml['pos'].to_i
        @inning_half = xml['inning_half']
      end
    end
  end
end
