class Genre
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  has_and_belongs_to_many :movies

  before_destroy :check_movies

  private
    def check_movies
      if movies.any?
        raise CustomError.new("The genre exists in the movie!", :bad_request)
      end
    end
end
