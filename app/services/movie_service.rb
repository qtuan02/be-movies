class MovieService < ApplicationService

  def index
    begin
      movies = Movie.includes(:country, :genres).all
      movies
    rescue
      raise StandardError
    end
  end

  def show(movie_id)
    begin
      movie = Movie.includes(:country, :genres).find(movie_id)
      movie
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      data[:country] = Country.find(data[:country_id])
      data[:genres] = data[:genre_ids].map { |genre| Genre.find(genre) }
      movie = Movie.new(data)
      movie.save ? movie : nil
    rescue
      raise StandardError
    end
  end

  def update(movie_id, data)
    begin
      movie = Movie.find(movie_id)
      if movie
        data[:country] = Country.find(data[:country_id])
        data[:genres] = data[:genre_ids].map { |genre| Genre.find(genre) }
        movie.update(data)
        movie
      else
        nil
      end
    rescue
      raise StandardError
    end
  end

end