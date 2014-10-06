module SportsDataApi
  class Stats
    def initialize(xml)
      if xml.is_a? Nokogiri::XML::Element
        
        @_values = {}
          
        stat_ivar = self.instance_variable_set("@#{xml.name}", @_values)
        self.class.class_eval { attr_reader :"#{xml.name}" }
        xml.attributes.each do | attr_name, attr_value|
          stat_ivar[attr_name.to_sym] = attr_value.value
        end
      end

      def [](search_index)
        @_values[search_index]
      end

      def each(&block)
        @_values.each do |k,v|
          if block_given?
            block.call(k,v)
          else
            yield stat
          end
        end
      end
    end
  end
end
