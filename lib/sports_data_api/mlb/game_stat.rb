module SportsDataApi
  module Mlb
    class GameStat
      attr_reader :player_id
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @stat_ivar = self.instance_variable_set("@#{xml.name}", {})
          self.class.class_eval { attr_reader :"#{xml.name}" }

          xml.attributes.each do | attr_name, attr_value|
            @stat_ivar[attr_name.to_sym] = attr_value.value
          end

          xml.xpath('.//*').each do |other_stat|
            if other_stat.is_a? Nokogiri::XML::Element
              other_stat.attributes.each do | attr_name, attr_value|
                collection = find_sub_collection(other_stat.name.to_sym)
                collection[attr_name.to_sym] = attr_value.value
              end
            end
          end
        end
      end

      def find_sub_collection(collection_id)
        @stat_ivar[collection_id] = {} unless @stat_ivar.include?(collection_id)
        @stat_ivar[collection_id]
      end

      def [](key)
        @stat_ivar[key]
      end
    end
  end
end
