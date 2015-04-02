module SportsDataApi
  module Nfl
    class GameStats
      attr_reader :id, :status, :home, :away, :teams, :quarter
      def initialize(year, season, week, xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet

        @id     = xml["id"]
        @status = xml["status"]
        @home   = xml["home"]
        @away   = xml["away"]
        @quarter = xml['quarter'].to_i

        @teams = []

        xml.xpath("team").each do |team_xml|
          teams << TeamGameStats.new(team_xml)
        end

#        def get_team(id)
#          @teams.each { |t| return t if t.id == id }
#          nil
#        end

        def home_stats
          @teams[0].id == home ?   @teams[0] : @teams[1]
        end

        def away_stats
          @teams[0].id == away ?   @teams[0] : @teams[1]
        end
      end
    end
  end
end
