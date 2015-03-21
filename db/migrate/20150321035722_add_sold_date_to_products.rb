class AddSoldDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sold_date, :date
  end
end
