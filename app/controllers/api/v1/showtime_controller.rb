class Api::V1::ShowtimeController < ApplicationController
  before_action :showtime_service
  before_action :body_check, only: %i[ create ]

  def index
    showtimes = @showtime_service.index(params[:page], params[:limit]).as_json(
      except: [:created_at, :updated_at, :movie_id, :cinema_id],
        include: {
          movie: {
            only: [ :name, :_id, :poster, :duration ],
            include: {
              country: { only: [:name, :_id] },
              genres: { only: [:name, :_id] }
            }
          },
          cinema: { except: [:created_at, :updated_at] }
    })
    
    json_response Message.get(:get_all_success), true, showtimes, :ok
  end

  def show
    showtime = @showtime_service.show(params[:id]).as_json(
      except: [:created_at, :updated_at, :movie_id, :cinema_id],
        include: {
          movie: {
            except: [:created_at, :updated_at, :country_id, :genre_ids],
            include: {
              country: { only: [:name, :_id] },
              genres: { only: [:name, :_id] }
            }
          },
          cinema: { except: [:created_at, :updated_at] }
    })

    if showtime
      json_response Message.get(:get_success), true, showtime, :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_showtime = @showtime_service.create(body_showtime)
    if new_showtime
      json_response Message.get(:create_success), true, new_showtime.as_json(except: [ :created_at, :updated_at ]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def update
    new_showtime = @showtime_service.update(params[:id], body_showtime)
    if new_showtime
      json_response Message.get(:update_success), true, new_showtime.as_json(except: [ :created_at, :updated_at ]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def showtime_service
      @showtime_service = ShowtimeService.new
    end

    def body_showtime
      params.permit(:show_date, :show_time, :price, :status, :movie_id, :cinema_id)
    end

    def body_check
      if params.dig(:show_date).blank? || params.dig(:show_time).blank? || params.dig(:price).blank? || params.dig(:movie_id).blank? || params.dig(:cinema_id).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end
