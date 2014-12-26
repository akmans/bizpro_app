class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments,
    {
      :id          => false,
      :primary_key => :shipment_id
    } do |t|
      t.string :shipment_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :shipmethod_id, :limit => 4, index: true
      t.date :sent_date
      t.date :arrived_date
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
