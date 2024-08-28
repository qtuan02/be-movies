class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :poster, type: String
  field :trailer, type: String
  field :name, type: String
  field :slug, type: String
  field :age_limit, type: Integer
  field :description, type: String
  field :release, type: String
  field :duration, type: Integer
  field :director, type: String
  field :actors, type: String

  belongs_to :country
  has_and_belongs_to_many :genres
  has_many :showtimes

end
