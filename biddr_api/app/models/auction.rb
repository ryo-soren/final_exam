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
