class Api::V1::CinemaController < ApplicationController
  before_action :cinema_service
  before_action :body_check, only: %i[ create update ]

  def index
    response = @cinema_service.index(params[:page], params[:limit], params[:name])
    json_response response[:total_pages], true, response[:cinemas].as_json(except: [:created_at, :updated_at]), :ok
  end

  def show
    cinema = @cinema_service.show(params[:id])
    if cinema
      json_response Message.get(:get_success), true, cinema.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_cinema = @cinema_service.create(body_cinema)
    if new_cinema
      json_response Message.get(:create_success), true, new_cinema.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def destroy
    is_destroy = @cinema_service.destroy(params[:id])
    if is_destroy
      json_response Message.get(:destroy_success), true, is_destroy, :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end
  
  def update
    new_cinema = @cinema_service.update(params[:id], body_cinema)
    if new_cinema
      json_response Message.get(:update_success), true, new_cinema.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def cinema_service
      @cinema_service = CinemaService.new
    end

    def body_cinema
      params.permit(:name, :location, :phone)
    end

    def body_check
      if params.dig(:name).blank? || params.dig(:location).blank? || params.dig(:phone).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end
