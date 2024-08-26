class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :fullname, type: String
  field :gender, type: Integer
  field :birthday, type: String
  field :address, type: String
  field :email, type: String
  field :phone, type: String
  field :password, type: String
  field :role, type: String, default: 'USER'
  field :status, type: Boolean, default: false

end
