class MovieService < ApplicationService

  def index(page, limit, name, country_id, genre_id)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if name
      conditions[:country_id] = country_id if country_id
      conditions[:genre_ids] = genre_id if genre_id

      page = page ? page.to_i : 1
      limit = limit ? limit.to_i : 5

      offset = (page - 1) * limit
      movies = Movie.where(conditions).order(created_at: :desc).skip(offset).limit(limit)
      
      total_pages = (Movie.where(conditions).count.to_f / limit).ceil

      { total_pages: total_pages , movies: movies }
    rescue
      raise StandardError
    end
  end

  def show(movie_id)
    begin
      movie = Movie.find(movie_id)
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
        data[:country] = Country.find(data[:country_id]) if data[:country_id]
        data[:genres] = data[:genre_ids].map { |genre| Genre.find(genre) } if data[:genre_ids]
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