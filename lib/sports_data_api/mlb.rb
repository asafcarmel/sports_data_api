module SportsDataApi
  module Mlb
    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'mlb')
    BASE_URL = 'http://api.sportsdatallc.org/mlb-%{access_level}%{version}'
    DEFAULT_VERSION = 5
    SPORT = :mlb

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
    autoload :Players, File.join(DIR, 'players')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Season, File.join(DIR, 'season')
    autoload :Broadcast, File.join(DIR, 'broadcast')
    autoload :GameStat, File.join(DIR,'game_stat')
    autoload :GameStats, File.join(DIR, 'game_stats')
    autoload :Boxscore, File.join(DIR, 'boxscore')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Venues, File.join(DIR, 'venues')
    autoload :PlayerSeasonStat, File.join(DIR, 'player_season_stat')
    autoload :PlayerSeasonStats, File.join(DIR, 'player_season_stats')
    autoload :LineupPlayer, File.join(DIR, 'lineup_player')
    autoload :Event, File.join(DIR, 'event')

    ##
    # Fetches all MLB teams
    def self.teams(version = DEFAULT_VERSION)
      response = self.response_json(version, "/league/hierarchy.json")
      return response
    end

    ##
    # Fetches MLB season schedule for a given year and season
    def self.schedule(year=Date.today.year,season='REG', version = DEFAULT_VERSION)
      season = self.get_season_symbol(season.to_s)
      response = self.response_json(version, "/games/#{year}/#{season}/schedule.json")
      return response
    end

    ##
    # Fetch MLB game stats
    def self.game_statistics(event_id, version = DEFAULT_VERSION )
      response = self.response_json(version, "/games/#{event_id}/summary.json")
      return response
    end

    ##
    # Fetch MLB Game Boxscore
    def self.game_boxscore(event_id, version = DEFAULT_VERSION )
      response = self.response_json(version, "/games/#{event_id}/boxscore.json")
      return response
    end

    # Fetch MLB seasonal statistics
    def self.seasonal_statistics(year,season,team_id, version = DEFAULT_VERSION )
      season = self.get_season_symbol(season.to_s)
      response = self.response_json(version, "/seasontd/#{year}/#{season}/teams/#{team_id}/statistics.json")
      return response
    end

    ##
    # Fetches MLB team roster
    def self.league_roster(version = DEFAULT_VERSION)
      response = self.response_json(version, "/league/full_rosters.json")
      return response
    end



    private
    def self.get_season_symbol(season)
      if (season == 'regular')
        return 'REG'
      elsif (season == 'post')
        return 'PST'
      elsif (season == 'pre')
        return 'PRE'
      else
        return season
      end
    end
    private
    def self.get_uri(version,url)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      base_url="#{base_url}#{url}"
    end

    private
    def self.response_json(version, url)
      base_url =get_uri(version,url)
      response = SportsDataApi.generic_request(base_url, SPORT)
      t=JSON.parse(response.to_s)
      t[:adr]=  base_url;
      t
    end

  end
end
