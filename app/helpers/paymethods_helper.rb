# encoding: utf-8
module PaymethodsHelper
  # return paymethod name by paymethod id
  def paymethod_name_help(paymethod_id)
    (Paymethod.find(paymethod_id).paymethod_name if Paymethod.exists?(paymethod_id)) || '-'
  end

  # return paymethod hash
  def paymethod_hash_help
    paymethods = {"" => "(空白)"}
    Paymethod.all.each do |bb| 
      paymethods.merge! bb.as_hash
    end
    return paymethods
  end
end
