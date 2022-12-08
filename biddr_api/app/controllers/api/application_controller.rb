class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token
    # protect_from_forgery with: :null_session
    # respond_to :json

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from StandardError, with: :standard_error
  
    def not_found
      render(
        json: {
          errors: [
            {
              type: "Not Found",
              message: "No route matches"
            }
          ]
        },
        status: 404
      )
    end
  
    private
  
    def authenticate_user!
      unless current_user.present?
        render(json: { status: 401 }, status: 401)
      end
    end
  
    protected
  
    def standard_error(error)
      logger.error error.full_message
  
      render(
        json: {
          errors: [
            {
              type: error.class.to_s,
              message: error.message
            }
          ]
        },
        status: 500
      )
    end
  
    def record_invalid(error)
      invalid_record = error.record_invalid
      errors = invalid_record.errors.map do |error_object|
        {
          type: invalid_record.class.to_s,
          field: error_object.attribute,
          message: error_object.options[:message]
        }
      end
      render(
        json: {
          status: 422,
          errors: errors,
        },
        status: 422
      )
    end
  
  end
  