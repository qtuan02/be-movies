class Cinema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :location, type: String
  field :phone, type: String

  has_many :showtimes

end
