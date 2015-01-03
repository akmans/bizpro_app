class CreatePaMaps < ActiveRecord::Migration
  def change
    create_table :pa_maps,
    {
      :id          => false,
      :primary_key => :auction_id
    } do |t|
      t.string :auction_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :product_id, :null => false, :limit => 20, index: true

      t.timestamps null: false
    end
  end
end
