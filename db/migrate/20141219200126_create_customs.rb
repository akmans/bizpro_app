class CreateCustoms < ActiveRecord::Migration
  def change
    create_table :customs,
    {
      :id          => false,
      :primary_key => :custom_id
    } do |t|
      t.string :custom_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :custom_name, :null => false, :limit => 200, index: true
      t.integer :is_auction, :limit => 1
      t.integer :percentage, :limit => 3
      t.string :auction_id, :limit => 20, index: true
      t.decimal :net_cost
      t.decimal :tax_cost
      t.decimal :other_cost
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
