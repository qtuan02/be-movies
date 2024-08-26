class GenreService < ApplicationService
  def index(page = nil, limit = nil, name = nil)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if name
      
      if page && limit
        offset = (page.to_i - 1) * limit.to_i
        genres = Genre.where(conditions).skip(offset).limit(limit.to_i)
      else
        genres = Genre.where(conditions)
      end

      genres
    rescue
      raise StandardError
    end
  end

  def show(genre_id)
    begin
      Genre.find(genre_id)
    rescue
      raise StandardError
    end
  end
  
  def create(data)
    begin
      genre = Genre.new(data)
      genre.save ? genre : nil
    rescue
      raise StandardError
    end
  end

  def destroy(genre_id)
    begin
      genre = Genre.find(genre_id)
      if genre
        genre.destroy
        genre_id
      else
        nil
      end
    rescue CustomError => e
      raise e
    rescue
      raise StandardError
    end
  end

  def update(genre_id, data)
    begin
      genre = Genre.find(genre_id)
      if genre
        genre.update(data)
        genre
      else
        nil
      end
    rescue
      raise StandardError
    end
  end
  
end