class ApplicationController < ActionController::Base
    def authenticate_user!
        redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
    end

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user
end

# ./api/application_controller

class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token

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

# ./api/v1

class Api::V1::AuctionsController < Api::ApplicationController

    before_action :authenticate_user!, only: [:create]

    def index
        auctions = Auction.order(created_at: :desc)
        render(
            json: auctions, each_serializer: AuctionCollectionSerializer
        )
    end

    def show
        auction = Auction.find(params[:id])
        render(
            json: auction, each_serializer: AuctionSerializer
        )
    end

    def create
        auction = Auction.new(auction_params)
        auction.user = current_user
        
        if auction.save
            render(
                json:{id: auction.id}
            )
        else
            render(
                json:{errors: auction.errors},
                status: 422
            )
        end
    end

    private

    def auction_params
        params.require(:auction).permit(:title, :description, :reserve_price, :closing_date)
    end

end

class Api::V1::BidsController < Api::ApplicationController
    before_action :authenticate_user!

    def create
        auction = Auction.find(params[:auction_id])

        bid = Bid.new(bid_params)
        bid.auction = auction
        bid.user = current_user
        
        if bid.save
            render(
                json:{ id: bid.id }
            )
        else
            render(
                json: {errors: bid.errors},
                status: 422
            )
        end
    end

    private

    def bid_params
        params.require(:bid).permit(:bid_price, :auction_id, :user_id)
    end
end

class Api::V1::SessionsController < Api::ApplicationController
    def create
        user = User.find_by_email params[:email]

        if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json:{ id: user.id }
        else
        render(
            json:{
                status: 404
            },
            status: 404
        ) 
        end
    end


    def destroy
        session[:user_id] = nil
        render json: {id: nil}    
    end

    def current
        render(json: current_user)
    end
end

class Api::V1::UsersController < Api::ApplicationController
    def create
        user_params = params.require(:user).permit(
            :name, :email, :password, :password_confirmation
            )
        user = User.new(user_params)
        
        if user.save
            session[:user_id] = user.id
            render json: {id: user.id}
        else
            render(
                json: {error: user.errors.messages},
                status: 422 
            )
        end
        
    end
end

  
  
  
