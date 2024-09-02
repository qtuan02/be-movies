class Cinema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :location, type: String
  field :phone, type: String

  has_many :showtimes

  before_destroy :check_showtimes

  private
    def check_showtimes
      if showtimes.any?
        raise CustomError.new("The cinema exists in the showtime!", :bad_request)
      end
    end

end
