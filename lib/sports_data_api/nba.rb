module SportsDataApi
  module Nba

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nba')
    BASE_URL = 'http://api.sportsdatallc.org/nba-%{access_level}%{version}'

    # Schedule
    autoload :Schedule,   File.join(DIR, 'schedule')
    autoload :Game, File.join(DIR, 'game')
    
    # Roosters and Teams
    autoload :Player, File.join(DIR, 'player')
    autoload :Team, File.join(DIR, 'team')
    autoload :League, File.join(DIR, 'league')
    
    # Statistics    
    autoload :SeasonalStatistics, File.join(DIR, 'seasonal_statistics')
    autoload :GameSummary, File.join(DIR, 'game_summary')    
    autoload :Stats, File.join(DIR, 'stats')    
    
    # Play by play
    autoload :PlayByPlay, File.join(DIR, 'play_by_play')
    autoload :Event, File.join(DIR, 'event')

    def self.play_by_play(game_id, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/games/#{game_id}/pbp.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      pbp = Nokogiri::XML(response.to_s)
      pbp.remove_namespaces!      
      return PlayByPlay.new(pbp.xpath("/game").first)
    end
    
    def self.seasonal_statistics(season_id, nba_season, team_id, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/seasontd/#{season_id}/#{nba_season}/teams/#{team_id}/statistics.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      statistics = Nokogiri::XML(response.to_s)
      statistics.remove_namespaces!      
      return SeasonalStatistics.new(statistics.xpath("/season/team").first)
    end
    
    def self.game_summary(game_id, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/games/#{game_id}/summary.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      game = Nokogiri::XML(response.to_s)
      game.remove_namespaces!
      return GameSummary.new(game.xpath("/game").first)
    end
        
    def self.schedule(season_id, nba_season, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/games/#{season_id}/#{nba_season}/schedule.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      schedule = Nokogiri::XML(response.to_s)
      schedule.remove_namespaces!
      return Schedule.new(schedule.xpath("/league/season-schedule").first)
    end

    def self.team_profile(team_id, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/#{team_id}/profile.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      team = Nokogiri::XML(response.to_s)
      team.remove_namespaces!

      return Team.new(team.xpath("/team").first)
    end
    
    
    def self.league_hierarchy(version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/league/hierarchy.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      hierarchy = Nokogiri::XML(response.to_s)
      hierarchy.remove_namespaces!
      
      return League.new(hierarchy.xpath("/league").first)
    end

    private
    def self.generic_request(url)
      begin
        return RestClient.get(url, params: { api_key: SportsDataApi.nba_key })
      rescue RestClient::RequestTimeout => timeout
        raise SportsDataApi::Exception, 'The API did not respond in a reasonable amount of time'
      rescue RestClient::Exception => e
        message = if e.response.headers.key? :x_server_error
                    JSON.parse(e.response.headers[:x_server_error], { symbolize_names: true })[:message]
                  elsif e.response.headers.key? :x_mashery_error_code
                    e.response.headers[:x_mashery_error_code]
                  else
                    "The server did not specify a message"
                  end
        raise SportsDataApi::Exception, message
      end
    end
  end
end
