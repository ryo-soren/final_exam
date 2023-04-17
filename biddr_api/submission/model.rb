class Auction < ApplicationRecord
    belongs_to :user
    has_many :bids, dependent: :destroy
  
    validates :title, presence: { message: "Title must be provided" }
    # validates :closing_date, presence: { message: "Date must be provided" }
    validates :description, presence: { message: "Description must be provided" }, length: { minimum: 10, too_short: "Description must be 10 characters minimum"}
    validates :reserve_price, presence: { message: "Price must be provided" }, numericality: { greater_than: 0 }
  
    before_validation :capitalize_title
    
    private
  
    def capitalize_title
      self.title.capitalize!
    end
  
    
end

class Bid < ApplicationRecord
    belongs_to :user
    belongs_to :auction
  
    validates :bid_price, presence: { message: "Price must be present"}, numericality: {greater_than: 0}
    
end

class User < ApplicationRecord
    has_secure_password

    has_many :auctions, dependent: :destroy
    has_many :bids, dependent: :destroy

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    validates :name, presence: :true
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

    before_validation :capitalize_name

    private

    def capitalize_name
      self.name.capitalize!
    end
  
end

  
  