class Ticket
  include Mongoid::Document
  include Mongoid::Timestamps

  field :seat_number, type: String
  field :price, type: Integer

  belongs_to :booking

end
