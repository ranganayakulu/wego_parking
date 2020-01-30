module ParkingLotsResponse
  def json_response(records, status = :ok)
    render json: records.as_json(only: resposne_keys), status: status
  end

  private
   
  def resposne_keys
    %i[address latitude longitude lots_available total_lots]
  end
end