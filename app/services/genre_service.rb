class GenreService < ApplicationService
  def index(page, limit, name)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if name

      page = page ? page.to_i : 1
      limit = limit ? limit.to_i : 5
      
      offset = (page - 1) * limit
      genres = Genre.where(conditions).order(created_at: :desc).skip(offset).limit(limit)

      total_pages = (Genre.where(conditions).count.to_f / limit).ceil

      { total_pages: total_pages , genres: genres }
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