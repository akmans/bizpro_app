class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions,
    {
      :id          => false,
      :primary_key => :auction_id
    } do |t|
      t.string :auction_id, :null => false, :limit => 20
      t.string :auction_name, :null => false, :limit => 200
      t.decimal :bidor_price
      t.decimal :price
      t.integer :quantity, :limit => 1
      t.integer :bids, :limit => 3
      t.string :seller_id, :limit => 50
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :url, :limit => 200
      t.integer :sold_flg, :limit => 1
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
