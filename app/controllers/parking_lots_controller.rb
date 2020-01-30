class ParkingLotsController < ApplicationController
  before_action :validate_request_params, only: [:nearest]
  include ParkingLotsResponse
  include ErrorResponse

  # GET /carparks/nearest
  # Mandatory params :latitude, :longitude
  # Rspec Refer: https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
  def nearest
    page, per_page = pagination(params)
    miles = search_with_in_miles(params)
    parking_lots = ParkingLot.within(miles, origin:[params[:latitude], params[:longitude]])
              .available_lots.sort_with_higher_availabiltiy
    size = parking_lots.size
    parking_lots = parking_lots.limit(per_page).offset(per_page * page)
    json_response(parking_lots, size)
  end

  private

  def validate_request_params
    unless (params[:latitude].present? && params[:longitude].present?)
      message = [':latitude and/or :longitude params missing in request.']
      json_error_response(message, :bad_request) and return
    end
  end

  def default_search_mile
    2
  end

  def pagination(params)
    page = 0
    per_page = 20
    if params[:page].present? &&
      params[:page].to_i > 0
      page = params[:page].to_i
    end
    if params[:per_page].present? &&
      params[:per_page].to_i > 0
      per_page = params[:per_page].to_i
    end
    [page, per_page]
  end

  def search_with_in_miles(params)
    miles = default_search_mile
    if params[:with_in].present? &&
      params[:with_in].to_i > 0
      miles = params[:with_in].to_i
    end
    miles
  end
end
