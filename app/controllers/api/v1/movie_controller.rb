class Api::V1::MovieController < ApplicationController
  before_action :movie_service
  before_action :body_check, only: %i[ create ]

  def index
    json_response Message.get(:get_all_success), true, @movie_service.index.as_json(except: [:created_at, :updated_at]), :ok
  end

  def create
    new_movie= @movie_service.create(body_movie)
    if new_movie
      json_response Message.get(:create_success), true, new_movie.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end 

  private
    def movie_service
      @movie_service = MovieService.new
    end

    def body_movie
      params.require(:movie).permit(:poster, :trailer, :name, :slug, :age_limit, :description, :release, :duration, :director, :actors, :country_id, genre_ids: [])
    end

    def body_check
      if params[:movie].blank? || params.dig(:movie, :name).blank? || params.dig(:movie, :poster).blank? || params.dig(:movie, :slug).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end