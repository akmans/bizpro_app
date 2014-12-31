class CreateShipmentDetails < ActiveRecord::Migration
  def change
    create_table :shipment_details do |t|
      t.string :shipment_id, :null => false, :limit => 20, index: true
      t.string :product_id, :null => false, :limit => 20, index: true
      t.decimal :ship_cost
      t.decimal :insured_cost
      t.decimal :custom_cost
      t.string :memo

      t.timestamps null: false
    end
  end
end
