class AddCancelFlgToCustoms < ActiveRecord::Migration
  def change
    add_column :customs, :cancel_flg, :integer, :limit => 1
  end
end
