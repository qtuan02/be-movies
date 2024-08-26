class Country
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  has_many :movies

  before_destroy :check_movies

  private
    def check_movies
      if movies.any?
        raise CustomError.new("The country exists in the movie!", :bad_request)
      end
    end
    
end
