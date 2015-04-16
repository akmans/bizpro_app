class AddRegistDateToCustoms < ActiveRecord::Migration
  def change
    add_column :customs, :regist_date, :date
  end
end
