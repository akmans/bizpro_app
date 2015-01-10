class CreateSolds < ActiveRecord::Migration
  def change
    create_table :solds do |t|
      t.string :product_id, :null => false, :limit => 20, index: true
      t.decimal :sold_price, :null => false
      t.decimal :ship_charge
      t.decimal :other_charge
      t.date :sold_date
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
