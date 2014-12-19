class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions,
    {
      :id          => false,
      :primary_key => :auction_id
    } do |t|
      t.string :auction_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :auction_name, :null => false, :limit => 200
      t.decimal :price
      t.integer :tax_rate, :limit => 2
      t.string :seller_id, :limit => 50
      t.timestamp :end_time
      t.string :url, :limit => 200
      t.integer :sold_flg, :limit => 1
      t.integer :is_custom, :limit => 1
      t.string :category_id, :limit => 4, index: true
      t.string :brand_id, :limit => 4, index: true
      t.string :modu_id, :limit => 7, index: true
      t.string :paymethod_id, :limit => 4
      t.decimal :payment_cost
      t.integer :ship_type, :limit => 1
      t.string :shipmethod_id, :limit => 4
      t.decimal :shipment_cost
      t.string :shipment_code, :limit => 12
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
    
#    add_index :auctions, :auction_id, :unique => true
  end
end
