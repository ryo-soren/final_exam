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
