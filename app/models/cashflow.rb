class Cashflow < ActiveRecord::Base
  self.table_name = 'v_cashflows'

  default_scope -> { order('case when happen_date is null then 1 else 0 end, happen_date desc') }
end
