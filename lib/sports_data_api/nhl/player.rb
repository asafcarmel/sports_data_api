module SportsDataApi
  module Nhl
    class Player
      attr_reader :stats, :goaltending
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          player_ivar = self.instance_variable_set("@#{xml.name}", {})
          self.class.class_eval { attr_reader :"#{xml.name}" }
          xml.attributes.each do |attr_name, attr_value|
            player_ivar[attr_name.to_sym] = attr_value.value
          end

          stats_xml = xml.xpath('statistics')
          if stats_xml.is_a? Nokogiri::XML::NodeSet and stats_xml.count > 0
            @stats = SportsDataApi::Stats.new(stats_xml.first)
          end

          goaltending_xml = xml.xpath('goaltending').first
          if goaltending_xml.is_a? Nokogiri::XML::Element
            @goaltending = SportsDataApi::Stats.new(goaltending_xml)
          end

          if @stats
            powerplay_xml = stats_xml.xpath('powerplay').first
            if powerplay_xml.is_a? Nokogiri::XML::Element
              powerplay_ivar = @stats.instance_variable_set("@#{powerplay_xml.name}", {})
              @stats.class.class_eval { attr_reader :"#{powerplay_xml.name}" }
              powerplay_xml.attributes.each { |attr_name, attr_value| powerplay_ivar[attr_name.to_sym] = attr_value.value }
            end
          end
        end
      end
    end
  end
end
