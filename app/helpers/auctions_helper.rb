#encoding: utf-8
module AuctionsHelper
  # Logs in the given user.
  def yahoojp_log_in_help(auth)
    session[:y_user_id] = auth.uid
    session[:y_token] = auth.credentials.token
    session[:y_refresh_token] = auth.credentials.refresh_token
    session[:y_expires_at] = auth.credentials.expires_at
    session[:y_user_name] = auth.info.name
    session[:y_email] = auth.info.email
  end

  # Returns true if the user islogged in Yahoo!Japan, false otherwise.
  def yahoojp_logged_in_help?
    !session[:y_user_id].nil?
  end

  # Logs out the current user.
  def yahoojp_log_out_help
    session.delete(:y_user_id)
    session.delete(:y_token)
    session.delete(:y_refresh_token)
    session.delete(:y_expires_at)
    session.delete(:y_user_name)
    session.delete(:y_email)
  end

  # return stirng of expires at
  def yahoojp_expires_at_help
    diff = session[:y_expires_at] - DateTime.now.to_i
    '%d:%02d:%02d' % [ diff / 3600, (diff / 60) % 60, diff % 60 ]
  end

#  # session will expire?
#  def yahoojp_will_expire?
#    diff = session[:y_expires_at] - DateTime.now.to_i
#    diff > 60 ? false : true
#  end

  # check session expired? or not
  def yahoojp_expired_help?
    diff = session[:y_expires_at] - DateTime.now.to_i
    diff < 0 ? true : false
  end

  # return tax rate hash
  def tax_rate_hash_help
    {"0" => "０％", "5" => "５％", "8" => "８％", "10" => "１０％"}
  end

  # return tax rate name
  def tax_rate_name_help(key)
    key.blank? ? "-" : tax_rate_hash_help[key.to_s]
  end

  # return ope flg hash
  def ope_flg_hash_help
    {"" => "(空白)", "0" => "カス品", "1" => "商品"}
  end

  # return sold type name
  def ope_flg_name_help(key)
    key.blank? ? "-" : ope_flg_hash_help[key.to_s]
  end

  # return the summary of custom percentage
  def custom_percentage_help(k)
    per = Custom.where(auction_id: k).sum(:percentage)
    return nil if per == 0
    return "(#{per}%)"
  end

  # return sold type hash
  def sold_type_hash_help
    {"0" => "買い品", "1" => "売り品"}
  end

  # return sold type name
  def sold_type_name_help(key)
    key.blank? ? "-" : sold_type_hash_help[key.to_s]
  end

  # return ship type hash help
  def ship_type_hash_help
    {"0" => "元払い", "1" => "着払い"}
  end

  # return ship type name help
  def ship_type_name_help(key)
    key.blank? ? "-" : ship_type_hash_help[key.to_s]
  end

  # auction_total_cost
  def auction_total_cost_help
    @auction.price * (100 + (@auction.tax_rate || 0)) / 100 + \
    (@auction.payment_cost || 0) + (@auction.shipment_cost || 0)
  end

  # return auction name by auction id
  def auction_name_help(auction_id)
    Auction.find(auction_id).auction_name
  end

  # return auction hash
  def auctions_hash_help(key)
    a_hash = {"" => "(空白)"}
    Auction.where(ope_flg: key).where.not(auction_id: PaMap.all).each do |auction|
      akey = auction.auction_id
      avalue = auction.auction_name
      new_hash = { akey => avalue}
      a_hash.merge! new_hash
    end
    return a_hash
  end
end