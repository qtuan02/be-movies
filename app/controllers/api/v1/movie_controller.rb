class Api::V1::MovieController < ApplicationController
  before_action :movie_service
  before_action :body_check, only: %i[ create ]

  def index
    movies = @movie_service.index(params[:page], params[:limit], params[:name], params[:country_id], params[:genre_id]).map do |movie|
      movie.as_json(
        except: [:created_at, :updated_at, :country_id, :genre_ids],
        include: {
          country: { only: [:name, :_id] },
          genres: { only: [:name, :_id] }
      })
    end

    json_response Message.get(:get_all_success), true, movies, :ok
  end

  def show
    movie = @movie_service.show(params[:id]).as_json(
      except: [:created_at, :updated_at, :country_id, :genre_ids],
        include: {
          country: { only: [:name, :_id] },
          genres: { only: [:name, :_id] }
    })

    if movie
      json_response Message.get(:get_success), true, movie, :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_movie= @movie_service.create(body_movie)
    if new_movie
      json_response Message.get(:create_success), true, new_movie.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def update
    new_movie= @movie_service.update(params[:id], body_movie)
    if new_movie
      json_response Message.get(:update_success), true, new_movie.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def movie_service
      @movie_service = MovieService.new
    end

    def body_movie
      params.permit(:poster, :trailer, :name, :slug, :age_limit, :description, :release, :duration, :director, :actors, :country_id, genre_ids: [])
    end

    def body_check
      if params.dig(:name).blank? || params.dig(:poster).blank? || params.dig(:slug).blank? || params.dig(:country_id).blank? || params.dig(:genre_ids).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end