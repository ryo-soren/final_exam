# SERIALIZERS

class AuctionCollectionSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :reserve_price, :seller, :closing_date, :created_at, :updated_at
  
    def seller
      object.user&.name
    end
  
end

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
  
# CORS

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '127.0.0.1:5500', 'localhost:5500'
      resource(
        '/api/*',
        headers: :any,
        credentials: true,
        methods: [:get, :post, :patch, :put, :options, :delete]
      )
    end
end