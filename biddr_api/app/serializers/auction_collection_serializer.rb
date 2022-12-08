class AuctionCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :reserve_price, :seller, :closing_date, :created_at, :updated_at

  def seller
    object.user&.name
  end

end
