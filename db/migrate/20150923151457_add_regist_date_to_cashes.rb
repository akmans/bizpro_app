class AddRegistDateToCashes < ActiveRecord::Migration
  def change
    add_column :cashes, :regist_date, :date
  end
end
