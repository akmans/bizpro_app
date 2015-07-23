class VCustom < ActiveRecord::Base
  self.table_name = 'v_customs'

  default_scope -> { order('case when regist_date is null then 1 else 0 end, regist_date desc') }
end
