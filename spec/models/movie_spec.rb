require 'rails_helper'

describe Movie do
  describe 'searching TMDB by keyword' do
    it 'calls Faraday gem with TMDb query' do
      expect(Faraday).to receive(:get).and_call_original
      Movie.find_in_tmdb({ title: 'hacker', language: 'en' })
    end

    it 'returns unsaved Movie objects with default rating R' do
      movies = Movie.find_in_tmdb({ title: 'Olympics', language: 'en' })
      expect(movies).to be_an(Array)
      expect(movies.length).to eq(2)
      expect(movies.first.title).to eq('Sydney 2000 Olympics Opening Ceremony')
      expect(movies.first.rating).to eq('R')
      expect(movies.first).not_to be_persisted
    end
  end
end