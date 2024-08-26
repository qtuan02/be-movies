class GenreService < ApplicationService
  def index(page = nil, limit = nil, search = nil)
    begin
      query = search ? { name: /#{search}/i } : {}
      
      if page && limit
        offset = page == 1 ? 0 : (limit.to_i * page.to_i) - (limit.to_i)
        genres = Genre.where(query).offset(offset).limit(limit)
      else
        genres = Genre.where(query)
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