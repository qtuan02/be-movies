class Api::V1::GenreController < ApplicationController
  before_action :genre_service
  before_action :body_check, only: %i[ create ]

  def index
    response = @genre_service.index(params[:page], params[:limit], params[:name])
    json_response response[:total_pages], true, response[:genres].as_json(except: [:created_at, :updated_at]), :ok
  end

  def show
    genre = @genre_service.show(params[:id])
    if genre
      json_response Message.get(:get_success), true, genre.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_genre = @genre_service.create(body_genre)
    if new_genre
      json_response Message.get(:create_success), true, new_genre.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def destroy
    is_destroy = @genre_service.destroy(params[:id])
    if is_destroy
      json_response Message.get(:destroy_success), true, is_destroy, :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def update
    new_genre = @genre_service.update(params[:id], body_genre)
    if new_genre
      json_response Message.get(:update_success), true, new_genre.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def genre_service
      @genre_service = GenreService.new
    end

    def body_genre
      params.permit(:name)
    end

    def body_check
      if params.dig(:name).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end
