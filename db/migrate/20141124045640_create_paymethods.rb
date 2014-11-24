class CreatePaymethods < ActiveRecord::Migration
  def change
    create_table :paymethods,
    {
      :id          => false,
      :primary_key => :paymethod_id
    } do |t|
      t.string :paymethod_id, :null => false, :limit => 4
      t.string :paymethod_name, :null => false, :limit => 100

      t.timestamps null: false
    end
    
    add_index :paymethods, :paymethod_id, :unique => true
  end
end
