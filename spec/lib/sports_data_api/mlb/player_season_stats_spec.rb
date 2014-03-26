require 'spec_helper'

describe SportsDataApi::Mlb::PlayerSeasonStats, vcr: {
  cassette_name: 'sports_data_api_mlb_season_stats',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  let(:stats) do
    SportsDataApi.set_key(:mlb, api_key("MLB"))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.player_season_stats("2013")
  end

  subject { stats }
  its(:count) { should eq 1304 }
end
