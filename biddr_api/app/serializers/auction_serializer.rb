class AuctionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :reserve_price, :seller_name, :closing_date, :created_at, :updated_at

  belongs_to :user, key: :seller
  has_many :bids

  def seller_name
    object.user&.name
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email
  end

  class BidSerializer < ActiveModel::Serializer
    attributes :id, :bid_price, :bidder

    def bidder
      object.user&.name
    end 

  end


end
