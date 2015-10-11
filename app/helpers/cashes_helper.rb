# encoding: utf-8
module CashesHelper
  # return yen amount
  def yen_amount_help(cash)
    return nil if cash.nil?
    return cash.amount if cash.is_domestic == 1
    return cash.amount * 100 / (cash.exchange_rate || 100) unless cash.is_domestic == 1
  end
end
