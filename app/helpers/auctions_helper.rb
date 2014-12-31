#encoding: utf-8
module AuctionsHelper
  # Logs in the given user.
  def yahoojp_log_in(auth)
    session[:y_user_id] = auth.uid
    session[:y_token] = auth.credentials.token
    session[:y_refresh_token] = auth.credentials.refresh_token
    session[:y_expires_at] = auth.credentials.expires_at
    session[:y_user_name] = auth.info.name
    session[:y_email] = auth.info.email
  end

  # Returns true if the user islogged in Yahoo!Japan, false otherwise.
  def yahoojp_logged_in?
    !session[:y_user_id].nil?
  end

  # Logs out the current user.
  def yahoojp_log_out
    session.delete(:y_user_id)
    session.delete(:y_token)
    session.delete(:y_refresh_token)
    session.delete(:y_expires_at)
    session.delete(:y_user_name)
    session.delete(:y_email)
  end

  # expires at
  def yahoojp_expires_at
    diff = session[:y_expires_at] - DateTime.now.to_i
    '%d:%02d:%02d' % [ diff / 3600, (diff / 60) % 60, diff % 60 ]
  end

  # session will expire?
  def yahoojp_will_expire?
    diff = session[:y_expires_at] - DateTime.now.to_i
    diff > 60 ? false : true
  end

  # session will expire?
  def yahoojp_expired?
    diff = session[:y_expires_at] - DateTime.now.to_i
    diff < 0 ? true : false
  end

  # tax_rate_hash
  def tax_rate_hash
    {"0" => "０％", "5" => "５％", "8" => "８％", "10" => "１０％"}
  end

  # tax_rate_name
  def tax_rate_name(key)
    key.blank? ? "-" : tax_rate_hash[key.to_s]
  end

  # ope_flg_hash
  def ope_flg_hash
    {"" => "(空白)", "0" => "カス品", "1" => "商品"}
  end

  # sold_type_name
  def ope_flg_name(key)
    key.blank? ? "-" : ope_flg_hash[key.to_s]
  end

  # custom_percentage
  def custom_percentage(k)
    per = Custom.where(auction_id: k).sum(:percentage)
    return nil if per == 0
    return "(#{per}%)"
  end

  # sold_type_hash
  def sold_type_hash
    {"0" => "買い品", "1" => "売り品"}
  end

  # sold_type_name
  def sold_type_name(key)
    key.blank? ? "-" : sold_type_hash[key.to_s]
  end

  # ship_type_hash
  def ship_type_hash
    {"0" => "元払い", "1" => "着払い"}
  end

  # ship_type_name
  def ship_type_name(key)
    key.blank? ? "-" : ship_type_hash[key.to_s]
  end

  # auction_total_cost
  def auction_total_cost
    @auction.price * (100 + (@auction.tax_rate || 0)) / 100 + \
    (@auction.payment_cost || 0) + (@auction.shipment_cost || 0)
  end

  def commas(x)
    str = x.to_s.reverse
    str.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def hiffen(x)
    str = x.to_s.reverse
    str.gsub(/(\d{4})(?=\d)/, '\\1-').reverse
  end

  def auction_name(key)
    Auction.find(key).auction_name
  end
 
  def auctions_hash
    a_hash = {"" => "(空白)"}
    Auction.where(ope_flg: 0).each do |auction|
      akey = auction.auction_id
      avalue = auction.auction_name
      new_hash = { akey => avalue}
      a_hash.merge! new_hash
    end
    a_hash
  end

  # form_select_hash
  def form_select_hash(key)
    @categories = {"" => "(空白)"}
    Category.all.each do |cc| 
      @categories.merge! cc.as_hash
    end
    @brands = {"" => "(空白)"}
    Brand.all.each do |bb|
      @brands.merge! bb.as_hash
    end
    @modus = {"" => "(空白)"}
    Modu.where(brand_id: key).each do |mm|
      @modus.merge! mm.as_hash
    end
    @paymethods = {"" => "(空白)"}
    Paymethod.all.each do |pp|
      @paymethods.merge! pp.as_hash
    end
    @shipmethods = {"" => "(空白)"}
    Shipmethod.where(shipmethod_type: 0).each do |ss|
      @shipmethods.merge! ss.as_hash
    end
  end
end
