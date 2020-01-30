module ErrorResponse
  def json_error_response(object, status)
    response = {}
    response[:error] = {}
    response[:error][:message] = object
    render json: response, status: status
  end
end