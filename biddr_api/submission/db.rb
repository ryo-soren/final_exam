# MIGRATIONS

class CreateUsers < ActiveRecord::Migration[7.0]
    def change
      create_table :users do |t|
        t.string :name
        t.string :email, index: {unique: true}
        t.string :password_digest
        t.timestamps
      end
    end
  end
  class CreateAuctions < ActiveRecord::Migration[7.0]
    def change
      create_table :auctions do |t|
        t.references :user, null: false, foreign_key: true
        t.string :title
        t.text :description
        t.integer :reserve_price
        t.datetime :closing_date
        t.timestamps
      end
    end
  end
  class CreateBids < ActiveRecord::Migration[7.0]
    def change
      create_table :bids do |t|
        t.references :user, null: false, foreign_key: true
        t.references :auction, null: false, foreign_key: true
        t.integer :bid_price
        t.timestamps
      end
    end
  end
      

# SCHEMA
ActiveRecord::Schema[7.0].define(version: 2022_12_07_190543) do
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
  
    create_table "auctions", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.string "title"
      t.text "description"
      t.integer "reserve_price"
      t.datetime "closing_date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_auctions_on_user_id"
    end
  
    create_table "bids", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "auction_id", null: false
      t.integer "bid_price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["auction_id"], name: "index_bids_on_auction_id"
      t.index ["user_id"], name: "index_bids_on_user_id"
    end
  
    create_table "users", force: :cascade do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  
    add_foreign_key "auctions", "users"
    add_foreign_key "bids", "auctions"
    add_foreign_key "bids", "users"
  end
# SEEDING
User.destroy_all
Auction.destroy_all
Bid.destroy_all


admin = User.create(
    name: "Admin User",
    email: "admin@user.com",
    password: "123"
)
10.times do
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123"
    )
end

users = User.all

50.times do
    created_at = Date.today
    future_date = Faker::Date.between(from: Date.today, to: "2024-01-01")
    a = Auction.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        reserve_price: rand(1000),
        user: users.sample,
        closing_date: future_date,
        created_at: created_at,
        updated_at: created_at
    )

    if a.valid?
        rand(1..5).times do
            Bid.create(
                bid_price: rand(a.reserve_price),
                auction: a,
                user: users.sample
            )
        end
    end
end

auctions = Auction.all
bids = Bid.all

puts "users: #{users.count}"
puts "auctions: #{auctions.count}"
puts "bids: #{bids.count}"

