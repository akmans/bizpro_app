class VAuction < ActiveRecord::Base
  self.table_name = 'v_auctions'

  default_scope -> { order('case when end_time is null then 1 else 0 end, end_time desc') }
end
