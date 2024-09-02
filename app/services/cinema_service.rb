class CinemaService < ApplicationService
  def index(page = nil, limit = nil, name = nil)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if  name
      
      if page && limit
        offset = (page.to_i - 1) * limit.to_i
        cinemas = Cinema.where(conditions).skip(offset).limit(limit)
      else
        cinemas = Cinema.where(conditions)
      end

      cinemas
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