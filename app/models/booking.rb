class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  field :total, type: Integer  
  field :status, type: Integer, default: 0

  belongs_to :showtime
  belongs_to :customer
  has_many :tickets
  
end
