class Movie < ApplicationRecord
  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end

  def self.find_in_tmdb(search_params, api_key = ENV['TMDB_API_KEY'] || 'fake_key')
    if search_params.is_a?(Hash) || search_params.is_a?(ActionController::Parameters)
      title = search_params[:title] || search_params['title']
      release_year = search_params[:release_year] || search_params['release_year']
      language = search_params[:language] || search_params['language'] || 'en'
    else
      title = search_params.to_s
      release_year = nil
      language = 'en'
    end

    return [] if title.blank?

    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{CGI.escape(title)}"
    url += "&year=#{release_year}" if release_year.present?
    url += "&language=#{language}" if language.present?

    response = Faraday.get(url)
    return [] unless response.success?

    data = JSON.parse(response.body)
    return [] unless data['results']

    data['results'].map do |movie_json|
      Movie.new(
        title: movie_json['title'],
        rating: 'R',
        description: movie_json['overview'],
        release_date: movie_json['release_date']
      )
    end
  end
end