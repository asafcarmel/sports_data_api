module SportsDataApi
  module Nba
    class Player
      attr_reader :id, :status, :full_name, :first_name, :last_name, :abbr_name, :weight, :height, :position, :primary_position,
      :jersey_number, :college, :birthdate
      
      def initialize(xml)        
        if xml.is_a? Nokogiri::XML::Element          
          @id = xml['id']
          @status = xml['status']            
          @full_name = xml['full_name']
          @first_name = xml['first_name']
          @last_name = xml['last_name']
          @abbr_name = xml['abbr_name']
          @weight = xml['weight']
          @height = xml['height']
          @position = xml['position']
          @primary_position = xml['primary_position']
          @jersey_number = xml['jersey_number'].to_i
          @birthdate = xml['birthdate']
        end
      end
    end
  end
end