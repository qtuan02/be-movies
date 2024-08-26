class MovieService < ApplicationService
  def index
    begin
      movies = Movie.all
      movies
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      movie = Movie.new(data)
      movie.save ? movie : nil
    rescue
      raise StandardError
    end
  end
end