class BookingService < ApplicationService
  def index
    begin
      Booking.all
    rescue
      raise StandardError
    end
  end
  
  def show(booking_id)
    begin
      Booking.find(booking_id)
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      booking = Booking.new(data.except(:tickets))
      if booking.save
        data[:tickets].each do |ticket|
          booking.tickets.create(ticket)
        end

        booking
      else
        nil
      end
    rescue
      raise StandardError
    end
  end

  def update(booking_id, data)
    begin
      booking = Booking.find(booking_id)
      if booking
        if data[:tickets]
          booking.tickets.destroy_all

          data[:tickets].each do |ticket|
            booking.tickets.create(ticket)
          end
        end

        booking.update(data.except(:tickets))
        booking
      else
        nil
      end
    rescue
      raise StandardError
    end
  end

end