class Api::V1::BookingController < ApplicationController
  before_action :booking_service
  before_action :body_check, only: %i[ create ]

  def index
    bookings = @booking_service.index.as_json(
      except: [ :created_at, :updated_at, :customer_id ],
      include: {
        customer: { only: [ :fullname, :email ]},
        showtime: { only: [ :movie_name ], methods: [ :movie_name ]}
      },
    )
    
    json_response Message.get(:get_all_success), true, bookings, :ok
  end

  def show
    booking = @booking_service.show(params[:id])
    if booking
      json_response Message.get(:get_success), true, booking.as_json(
        except: [ :created_at, :updated_at, :customer_id ],
        include: {
          customer: { only: [ :fullname, :email ]},
          showtime: { only: [ :movie_name ], methods: [ :movie_name ]}
        },
      ), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_booking = @booking_service.create(body_booking)
    if new_booking
      json_response Message.get(:create_success), true, new_booking.as_json(except: [ :create_at, :updated_at ]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def update
    new_booking = @booking_service.update(params[:id], body_booking)
    if new_booking
      json_response Message.get(:update_success), true, new_booking.as_json(except: [ :create_at, :updated_at ]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def booking_service
      @booking_service = BookingService.new
    end

    def body_booking
      params.permit(:total, :status, :showtime_id, :customer_id, tickets: [ :seat_number, :price ])
    end

    def body_check
      if params.dig(:total).blank? || params.dig(:showtime_id).blank? || params.dig(:customer_id).blank? || params.dig(:tickets).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end
