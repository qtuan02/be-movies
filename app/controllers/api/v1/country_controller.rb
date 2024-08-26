class Api::V1::CountryController < ApplicationController
  before_action :country_service
  before_action :body_check, only: %i[ create update ]

  def index
    countries = @country_service.index(params[:page], params[:limit], params[:name])
    json_response Message.get(:get_all_success), true, countries.as_json(except: [:created_at, :updated_at]), :ok
  end

  def show
    country = @country_service.show(params[:id])
    if country
      json_response Message.get(:get_success), true, country.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def create
    new_country = @country_service.create(body_country)
    if new_country
      json_response Message.get(:create_success), true, new_country.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:create_fail), false, nil, :bad_request
    end
  end

  def destroy
    is_destroy = @country_service.destroy(params[:id])
    if is_destroy
      json_response Message.get(:destroy_success), true, params[:id], :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  def update
    new_country = @country_service.update(params[:id], body_country)
    if new_country
      json_response Message.get(:update_success), true, new_country.as_json(except: [:created_at, :updated_at]), :ok
    else
      json_response Message.get(:not_found), false, nil, :not_found
    end
  end

  private
    def country_service
      @country_service = CountryService.new
    end

    def body_country
      params.permit(:name)
    end

    def body_check
      if params.dig(:name).blank?
        json_response Message.get(:field_empty), false, nil, :bad_request
      end
    end
end