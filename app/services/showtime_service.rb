class ShowtimeService < ApplicationService
  def index(page = nil, limit = nil)
    begin
      if page && limit
        offset = (page.to_i - 1) * limit.to_i
        showtimes = Showtime.skip(offset).limit(limit.to_i).all
      else
        showtimes = Showtime.all
      end

      showtimes
    rescue
      raise StandardError
    end
  end

  def show(showtime_id)
    begin
      showtime = Showtime.find(showtime_id)
      showtime
    rescue
      raise StandardError
    end
  end
  
  def create(data)
    begin
      data[:cinema] = Cinema.find(data[:cinema_id])
      data[:movie] = Movie.find(data[:movie_id])
      showtime = Showtime.new(data)
      showtime.save ? showtime : nil
    rescue
      raise StandardError
    end
  end

  def update(showtime_id, data)
    begin
      showtime = Showtime.find(showtime_id)
      if showtime
        data[:cinema] = Cinema.find(data[:cinema_id]) if data[:cinema_id]
        data[:movie] = Movie.find(data[:movie_id]) if data[:movie_id]
        showtime.update(data)
        showtime
      else
        nil
      end
    rescue
      raise StandardError
    end
  end

end