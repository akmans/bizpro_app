class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands,
    {
      :id          => false,
      :primary_key => :brand_id
    }  do |t|
      t.string :brand_id, :null => false, :limit => 4
      t.string :brand_name, :null => false, :limit => 100

      t.timestamps null: false
    end
    
    add_index :brands, :brand_id, :unique => true
  end
end
