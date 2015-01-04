class CreatePcMaps < ActiveRecord::Migration
  def change
    create_table :pc_maps,
    {
      :id          => false,
      :primary_key => :custom_id
    } do |t|
      t.string :custom_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :product_id, :null => false, :limit => 20, index: true

      t.timestamps null: false
    end
  end
end
