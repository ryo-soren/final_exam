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