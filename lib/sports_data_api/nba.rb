module SportsDataApi
  module Nba
    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nba')
    BASE_URL = 'http://api.sportsdatallc.org/nba-%{access_level}%{version}'
    DEFAULT_VERSION = 3
    SPORT = :nba

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

    def self.play_by_play(game, version = 3)
      response = self.response_xml(version, "/games/#{game}/pbp.xml")
      return PlayByPlay.new(response.xpath("/game").first)
    end

    def self.seasonal_statistics(year, season, team, version = 3)
      response = self.response_xml(version, "/seasontd/#{year}/#{season}/teams/#{team}/statistics.xml")
      return SeasonalStatistics.new(response.xpath("/season/team").first)
    end

    ##
    # Fetches NBA game summary for a given game
    def self.game_summary(game, version = DEFAULT_VERSION)
      response = self.response_xml(version, "/games/#{game}/summary.xml")

      return GameSummary.new(response.xpath("/game").first)
    end

    ##
    # Fetches NBA season schedule for a given year and season
    def self.schedule(year, season, version = DEFAULT_VERSION)
      #          season = season.to_s.upcase.to_sym
      response = self.response_xml(version, "/games/#{year}/#{season}/schedule.xml")
      return Schedule.new(response.xpath("/league/season-schedule//game"))
    end

    ##
    # Fetches NBA series schedule for a given year and season
    def self.series_schedule(year, season, version = DEFAULT_VERSION)
      response = self.response_xml(version, "/series/#{year}/#{season}/schedule.xml")
      return Schedule.new(response.xpath("/league/season-schedule//game"))
    end

    def self.team_profile(team, version = DEFAULT_VERSION)
      response = self.response_xml(version, "/teams/#{team}/profile.xml")
      return Team.new(response.xpath("/team").first)
    end

    ##
    # Fetches all NBA teams
    def self.league_hierarchy(version = DEFAULT_VERSION)
      response = self.response_xml(version, "/league/hierarchy.xml")

      return League.new(response.xpath('/league').first)
    end

    private

    def self.response_xml(version, url)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      response = SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
      Nokogiri::XML(response.to_s).remove_namespaces!
    end
  end
end
