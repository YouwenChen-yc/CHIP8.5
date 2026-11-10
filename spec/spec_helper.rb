require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  json_return = {
    "page" => 1,
    "results" => [
      {
        "adult" => false,
        "backdrop_path" => "/kqMV9VUrGv9BbmRTOzXKyIraeOG.jpg",
        "genre_ids" => [],
        "id" => 716088,
        "original_language" => "en",
        "original_title" => "Sydney 2000 Olympics Opening Ceremony",
        "overview" => "Coverage of the glorious Olympic Opening Ceremony of the Games in Sydney.",
        "popularity" => 3.733,
        "poster_path" => "/nE9GGznpsYPuRIg3kCBgsfCwC2j.jpg",
        "release_date" => "2000-09-15",
        "title" => "Sydney 2000 Olympics Opening Ceremony",
        "video" => false,
        "vote_average" => 7.3,
        "vote_count" => 3
      },
      {
        "adult" => false,
        "backdrop_path" => "/7MMlToGu6JBVtL7myvNQIq0qtIf.jpg",
        "genre_ids" => [],
        "id" => 716098,
        "original_language" => "en",
        "original_title" => "Sydney 2000 Olympics Closing Ceremony",
        "overview" => "The 2000 Summer Olympics Closing Ceremony took place on 1 October 2000 in Stadium Australia.",
        "popularity" => 1.308,
        "poster_path" => "/jSxterIFJPP5CDZ4Jderik25hxT.jpg",
        "release_date" => "2000-10-01",
        "title" => "Sydney 2000 Olympics Closing Ceremony",
        "video" => false,
        "vote_average" => 10,
        "vote_count" => 1
      }
    ],
    "total_pages" => 1,
    "total_results" => 2
  }

  config.before(:each) do
    stub_request(:get, /api.themoviedb.org/).
      to_return(status: 200, body: JSON.generate(json_return), headers: { 'Content-Type' => 'application/json' })
  end
end