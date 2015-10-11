class CreateCashes < ActiveRecord::Migration
  def change
    create_table :cashes,
    {
      :id          => false,
      :primary_key => :cash_id
    } do |t|
      t.string :cash_id, :null => false, :limit => 20, index: {:unique => true}
      t.string :remark, :null => false, :limit => 200, index: true
      t.integer :is_domestic, :limit => 1
      t.integer :is_in, :limit => 1
      t.decimal :exchange_rate
      t.string :memo, :limit => 200

      t.timestamps null: false
    end
  end
end
