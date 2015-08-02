class VProduct < ActiveRecord::Base
  self.table_name = 'v_products'

  default_scope -> { order('case when sold_date is null then 1 else 0 end, sold_date desc') }
end
