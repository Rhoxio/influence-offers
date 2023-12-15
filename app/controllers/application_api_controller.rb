class ApplicationApiController < ApplicationController
  include ApiErrorHandling

  rescue_from ActiveRecord::RecordNotFound do |e|
    respond_with_error('not_found', nil, "Record was not found")
  end  

  rescue_from ActiveRecord::RecordInvalid do |e|
    respond_with_error('unprocessable_entity', nil, "#{e.message}")
  end  

  rescue_from ActiveRecord::RecordNotUnique do |e|
    respond_with_error('conflict', nil, "#{e.message}")
  end    

  
end