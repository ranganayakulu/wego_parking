class ParkingLotsController < ApplicationController
  before_action :validate_request_params, only: [:nearest]
  include ParkingLotsResponse
  include ErrorResponse

  def nearest
    params[:with_in] = params[:with_in].to_i || default_search_mile
    @parking_lots = ParkingLot.within(params[:with_in], origin:[params[:latitude], params[:longitude]])
              .available_lots.sort_with_higher_availabiltiy
    @parking_lots.limit(params[:page]).offset(params[:per_page])
    json_response(@parking_lots)
  end

  private

  def validate_request_params
    unless params[:latitude].present? && params[:longitude].present?
      message = [':latitude and/or :longitude params missing in request.']
      json_error_response(message, :bad_request) and return
    end
  end

  def default_search_mile
    2
  end
end
