class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products,
    {
      :id          => false,
      :primary_key => :product_id
    } do |t|
      t.string :product_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :product_name, :null => false, :limit => 200, index: true
      t.integer :is_domestic, :limit => 1
      t.decimal :exchange_rate
      t.string :category_id, :limit => 4, index: true
      t.string :brand_id, :limit => 4, index: true
      t.string :modu_id, :limit => 7, index: true
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
