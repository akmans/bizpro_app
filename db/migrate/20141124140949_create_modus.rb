class CreateModus < ActiveRecord::Migration
  def change
    create_table :modus,
    {
      :id          => false,
      :primary_key => :modu_id
    } do |t|
      t.string :modu_id, :null => false, :limit => 7
      t.string :modu_name, :null => false, :limit => 100
      t.string :brand_id, :null => false, :limit => 4, index: true

      t.timestamps null: false
    end
    
    add_index :modus, :modu_id, :unique => true
  end
end
