class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories,
    {
      :id          => false,
      :primary_key => :category_id
    } do |t|
      t.string :category_id, :null => false, :limit => 4
      t.string :category_name, :null => false, :limit => 100

      t.timestamps null: false
    end
    
    add_index :categories, :category_id, :unique => true
  end
end
