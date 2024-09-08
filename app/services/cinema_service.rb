class CinemaService < ApplicationService
  def index(page, limit, name)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if  name

      page = page ? page.to_i : 1
      limit = limit ? limit.to_i : 5
      
      offset = (page - 1) * limit
      cinemas = Cinema.where(conditions).order(created_at: :desc).skip(offset).limit(limit)

      total_pages = (Cinema.where(conditions).count.to_f / limit).ceil

      { total_pages: total_pages, cinemas: cinemas }
    rescue
      raise StandardError
    end
  end

  def show(cinema_id)
    begin
      Cinema.find(cinema_id)
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      cinema = Cinema.new(data)
      cinema.save ? cinema : nil
    rescue
      raise StandardError
    end
  end

  def destroy(cinema_id)
    begin
      cinema = Cinema.find(cinema_id)
      if cinema
        cinema.destroy
        cinema
      else
        nil
      end
    rescue CustomError => e
      raise e
    rescue
      raise StandardError
    end
  end

  def update(cinema_id, data)
    begin
      cinema = Cinema.find(cinema_id)
      if cinema
        cinema.update(data)
        cinema
      else
        nil
      end
    rescue
      raise StandardError
    end
  end

end