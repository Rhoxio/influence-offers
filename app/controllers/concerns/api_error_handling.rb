module ApiErrorHandling
  # Generalized error handling method with flexible options for use in api controllers.
  def respond_with_error(error, invalid_resource = nil, message = nil)
    error = $API_ERRORS[error]
    error['details'] = invalid_resource.errors.full_messages if invalid_resource
    error['message'] = message if message
    render json: error, status: error['status']
  end
end