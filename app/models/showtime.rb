class Showtime
  include Mongoid::Document
  include Mongoid::Timestamps

  field :show_date, type: String
  field :show_time, type: String
  field :price, type: Integer
  field :status, type: Boolean, default: false

  belongs_to :movie
  belongs_to :cinema

end
