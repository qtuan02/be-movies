class Showtime
  include Mongoid::Document
  include Mongoid::Timestamps

  field :movie_id, type: BSON::ObjectId
  field :theater_id, type: BSON::ObjectId
  field :show_date, type: String
  field :show_times, type: Array, default: []
  field :ticket_price, type: Integer
  field :status, type: String, default: false
  field :sold, type: Integer, default: 0

end
