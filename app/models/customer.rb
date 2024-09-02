class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :customer_id, type: String
  field :email, type: String
  field :fullname, type: String
  field :birthday, type: String
  field :phone, type: String
  field :address, type: String
  field :gender, type: Integer
  field :point, type: Integer, default: 0
  field :status, type: Boolean, default: true

  has_many :bookings

end
