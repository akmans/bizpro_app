class AddAmountToCashes < ActiveRecord::Migration
  def change
    add_column :cashes, :amount, :decimal
  end
end
