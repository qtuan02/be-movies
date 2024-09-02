class Api::V1::CustomerController < ApplicationController
  before_action :customer_service
  before_action :body_check, only: %i[ create ]

  def index
    customers = @customer_service.index
    json_response Message.get(:get_all_success), true, customers.as_json(except: [ :created_at, :updated_at ]), :ok
  end

  def show
    customer = @customer_service.show(params[:id])
    if customer
      json_response Message.get(:get_success), true, customer.as_json(except: [ :created_at, :updated_at ]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_customer = @customer_service.create(body_customer)
    if new_customer
      json_response Message.get(:create_success), true, new_customer.as_json(except: [ :created_at, :updated_at ]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def update
    new_customer = @customer_service.update(params[:id], body_customer)
    if new_customer
      json_response Message.get(:update_success), true, new_customer.as_json(except: [ :created_at, :updated_at ]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def customer_service
      @customer_service = CustomerService.new
    end

    def body_customer
      params.permit(:email, :fullname, :birthday, :phone, :address, :gender, :point, :status)
    end

    def body_check
      if params.dig(:email).blank? || params.dig(:fullname).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end

end
