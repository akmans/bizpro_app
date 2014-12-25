class CreateShipmethods < ActiveRecord::Migration
  def change
    create_table :shipmethods,
    {
      :id          => false,
      :primary_key => :shipmethod_id
    } do |t|
      t.string :shipmethod_id, :null => false, :limit => 4
      t.integer :shipmethod_type, :null => false, :limit => 1
      t.string :shipmethod_name, :null => false, :limit => 100

      t.timestamps null: false
    end
    
    add_index :shipmethods, :shipmethod_id, :unique => true
  end
end
