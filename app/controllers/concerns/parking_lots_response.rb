module ParkingLotsResponse
  def json_response(records, total_records, status = :ok)
    response = {}
    response[:count] = total_records
    response[:carparks] = records.as_json(only: resposne_keys)
    render json: response, status: status
  end

  private
   
  def resposne_keys
    %i[address latitude longitude lots_available total_lots]
  end
end