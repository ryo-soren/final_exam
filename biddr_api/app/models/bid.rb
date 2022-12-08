class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :bid_price, presence: { message: "Price must be present"}, numericality: {greater_than: 0}
  
end
