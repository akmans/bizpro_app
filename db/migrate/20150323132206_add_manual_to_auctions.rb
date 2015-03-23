class AddManualToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :manual, :integer
  end
end
