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
