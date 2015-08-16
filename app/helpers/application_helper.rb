# encoding: utf-8

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title_help(page_title = '')
    base_title = 'オーディオPRO'
    if page_title.empty?
      base_title
    else
      title = page_title.split(',') << base_title
      title.join(' | ')
    end
  end

  # add commas to given string
  def commas_help(x)
    str = x.to_s.reverse
    str.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  # add hiffen to given string
  def hiffen_help(x)
    str = x.to_s.reverse
    str.gsub(/(\d{4})(?=\d)/, '\\1-').reverse
  end

  # generate month hash
  def month_hash_help
    month = {"" => "(月)"}
    (1..12).each do |m|
      month[m] = "#{m}月"
    end
    return month
  end

  # generate year hash
  def year_hash_help
    year = {"" => "(年)"}
    (2011..2015).each do |y|
      year[y] = "#{y}年"
    end
    return year
  end

  # return is domestic hash
  def is_domestic_hash_help
    {"0" => "海外(共)", "1" => "国内", "2" => "海外(兄)", "3" => "発送中"}
  end

  # return is domestic name by key
  def is_domestic_name_help(key)
    key.blank? ? "-" : is_domestic_hash_help[key.to_s]
  end

  # generate is in hash
  def is_in_hash_help
    {"" => "(全部)", "0" => "OUT", "1" => "IN"}
  end

  # generate is auction hash
  def is_auction_hash_help
    {"" => "(全部)", "0" => "非オーク品", "1" => "オーク品"}
  end

  # generate sold flag hash
  def undeal_product_sold_flg_help
    {"" => "(全部)", "0" => "未売却", "1" => "売却済"}
  end

  # generate undeal_auction hash
  def undeal_auction_hash_help
    {"" => "(全部)", "0" => "区分未登録", "1" => "商品未登録", "2" => "カス未登録"}
  end

  # generate undeal_custom hash
  def undeal_custom_hash_help
    {"" => "(全部)", "0" => "未登録", "1" => "登録済"}
  end

  # generate shipment_status hash
  def shipment_status_hash_help
    {"" => "(全部)", "0" => "発送中", "1" => "到着済"}
  end

  # ---------------------- utilities function(LEVEL 1) --------------------------
  # count product
  def count_product(condition, beginning_date, end_date)
    # all
    product = Product.where(is_domestic: condition["is_domestic"])
    # sold_flg
    product = product.where(sold_date: nil) if condition["sold_flg"] == '0'
    product = product.where.not(sold_date: nil) if condition["sold_flg"] == '1'
    # category_id
    product = product.where(category_id: condition["category_id"]) \
              unless condition["category_id"].blank?
    # product_name
    product = product.where("product_name like :product_name", \
              {:product_name => "%#{condition['product_name']}%"}) \
              unless condition["product_name"].blank?
    # beginning date
    product = product.where("sold_date >= :date_s", {:date_s => beginning_date}) \
        unless beginning_date.blank?
    # end date
    product = product.where("sold_date <= :date_e", {:date_e => end_date}) \
        unless end_date.blank?
    # year or month
    return product.count
  end

  # cost_calculate(date_type 0:all 1:year 2:month)
  def cost_calculate(condition, beginning_date, end_date)
    product = VProduct.select("SUM(COALESCE(auc_cost, 0) + COALESCE(cus_cost, 0) + " \
              + "COALESCE(shipment_cost_jpy, 0) + COALESCE(shipment_cost_rmb, 0) * 100 / " \
              + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END)) as cost_jp, " \
              + "SUM((COALESCE(auc_cost, 0) + COALESCE(cus_cost, 0) + " \
              + "COALESCE(shipment_cost_jpy, 0)) * " \
              + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100 + " \
              + "COALESCE(shipment_cost_rmb, 0)) as cost_rmb, " \
              + "SUM(COALESCE(auc_in, 0)) as income_jp, " \
              + "SUM(COALESCE(sold_rmb, 0)) as income_rmb")
    # sold_flg
    product = product.where(sold_date: nil) if condition["sold_flg"] == '0'
    product = product.where.not(sold_date: nil) if condition["sold_flg"] == '1'
    # category_id
    product = product.where(category_id: condition["category_id"]) \
              unless condition["category_id"].blank?
    # product_name
    product = product.where("product_name like :product_name", \
              {:product_name => "%#{condition['product_name']}%"}) \
              unless condition["product_name"].blank?
    # beginning date
    product = product.where("sold_date >= :date_s", {:date_s => beginning_date}) \
        unless beginning_date.blank?
    # end date
    product = product.where("sold_date <= :date_e", {:date_e => end_date}) \
        unless end_date.blank?
    return product.reorder('').first
  end
#  # cost calculate(date_type 0:all 1:year 2:month)
#  def cost_calculate(condition, beginning_date, end_date)
#    cost = {}
#    # auction cost------------------------------
#    auction = Auction.select("SUM((price * (tax_rate + 100) / 100 + " \
#        + "COALESCE(payment_cost, 0) + COALESCE(shipment_cost, 0)) * " \
#        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100) as amount, " \
#        + "SUM(price * (tax_rate + 100) / 100 + COALESCE(payment_cost, 0) + " \
#        + "COALESCE(shipment_cost, 0)) as amount_jp") \
#        .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
#        .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
#        .where("products.is_domestic = :is_domestic", {:is_domestic => condition["is_domestic"]}) \
#        .where(sold_flg: 0)
#    # product_id
#    auction = auction.where("products.product_id = :product_id", \
#        {:product_id => condition["product_id"]}) unless condition["product_id"].blank?
#    # sold_flg
#    auction = auction.where("products.sold_date is null") if condition["sold_flg"] == '0'
#    auction = auction.where("products.sold_date is not null") if condition["sold_flg"] == '1'
#    # category_id
#    auction = auction.where("products.category_id = :category_id", \
#              category_id: condition["category_id"]) unless condition["category_id"].blank?
#    # product_name
#    auction = auction.where("products.product_name like :product_name", \
#              {:product_name => "%#{condition['product_name']}%"}) \
#              unless condition["product_name"].blank?
#    # beginning date
#    auction = auction.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
#        unless beginning_date.blank?
#    # end date
#    auction = auction.where("products.sold_date <= :date_e", {:date_e => end_date}) \
#        unless end_date.blank?
#    auction = auction.reorder('').first
#    bought1 = auction.amount.to_f
#    bought1_jp = auction.amount_jp.to_f
#    # custom cost(non auction)------------------------------
#    custom = Custom.select("SUM((COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) * " \
#        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100) as amount, " \
#        + "SUM(COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) as amount_jp") \
#        .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
#        .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id ") \
#        .where("products.is_domestic = :is_domestic", {:is_domestic => condition["is_domestic"]}) \
#        .where(is_auction: 0)
#    # product_id
#    custom = custom.where("products.product_id = :product_id", \
#        {:product_id => condition["product_id"]}) unless condition["product_id"].blank?
#    # sold_flg
#    custom = custom.where("products.sold_date is null") if condition["sold_flg"] == '0'
#    custom = custom.where("products.sold_date is not null") if condition["sold_flg"] == '1'
#    # category_id
#    custom = custom.where("products.category_id = :category_id", \
#             category_id: condition["category_id"]) unless condition["category_id"].blank?
#    # product_name
#    custom = custom.where("products.product_name like :product_name", \
#             {:product_name => "%#{condition['product_name']}%"}) \
#             unless condition["product_name"].blank?
#    # beginning date
#    custom = custom.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
#        unless beginning_date.blank?
#    # end date
#    custom = custom.where("products.sold_date <= :date_e", {:date_e => end_date}) \
#        unless end_date.blank?
#    custom = custom.reorder('').first
#    bought2 = custom.amount.to_f
#    bought2_jp = custom.amount_jp.to_f
#    # custom cost(auction)------------------------------
#    custom2 = Custom.select("SUM((price * (tax_rate + 100) / 100 + " \
#        + "COALESCE(payment_cost, 0) + COALESCE(shipment_cost, 0)) * " \
#        + "(CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) * " \
#        + "percentage / 100 / 100) as amount, " \
#        + "SUM((price * (tax_rate + 100) / 100 + COALESCE(payment_cost, 0) + " \
#        + "COALESCE(shipment_cost, 0)) * percentage / 100) as amount_jp") \
#        .joins("LEFT JOIN auctions ON customs.auction_id = auctions.auction_id ") \
#        .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
#        .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id") \
#        .where("products.is_domestic = :is_domestic", {:is_domestic => condition["is_domestic"]}) \
#        .where(is_auction: 1)
#    # product_id
#    custom2 = custom2.where("products.product_id = :product_id", \
#        {:product_id => condition["product_id"]}) unless condition["product_id"].blank?
#    # sold_flg
#    custom2 = custom2.where("products.sold_date is null") if condition["sold_flg"] == '0'
#    custom2 = custom2.where("products.sold_date is not null") if condition["sold_flg"] == '1'
#    # category_id
#    custom2 = custom2.where("products.category_id = :category_id", \
#              category_id: condition["category_id"]) unless condition["category_id"].blank?
#    # product_name
#    custom2 = custom2.where("products.product_name like :product_name", \
#              {:product_name => "%#{condition['product_name']}%"}) \
#              unless condition["product_name"].blank?
#    # beginning date
#    custom2 = custom2.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
#        unless beginning_date.blank?
#    # end date
#    custom2 = custom2.where("products.sold_date <= :date_e", {:date_e => end_date}) \
#        unless end_date.blank?
#    custom2 = custom2.reorder('').first
#    bought3 = custom2.amount.to_f
#    bought3_jp = custom2.amount_jp.to_f
#    # offshore shipment cost------------------------------
#    shipment_detail = ShipmentDetail.select("SUM((COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0) + " \
#        + "COALESCE(custom_cost, 0) * 100 / (CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) " \
#        + ") * ((CASE is_domestic WHEN 1 THEN 100 ELSE exchange_rate END) / 100)) as amount, " \
#        + "SUM(COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0)) as amount_jp, " \
#        + "SUM(COALESCE(custom_cost, 0)) as amount_cn") \
#        .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
#        .where("products.is_domestic = :is_domestic", {:is_domestic => condition["is_domestic"]})
#    # product_id
#    shipment_detail = shipment_detail.where("products.product_id = :product_id", \
#        {:product_id => condition["product_id"]}) unless condition["product_id"].blank?
#    # sold_flg
#    shipment_detail = shipment_detail.where("products.sold_date is null") if condition["sold_flg"] == '0'
#    shipment_detail = shipment_detail.where("products.sold_date is not null") if condition["sold_flg"] == '1'
#    # category_id
#    shipment_detail = shipment_detail.where("products.category_id = :category_id", \
#        category_id: condition["category_id"]) unless condition["category_id"].blank?
#    # product_name
#    shipment_detail = shipment_detail.where("products.product_name like :product_name", \
#        {:product_name => "%#{condition['product_name']}%"}) \
#        unless condition["product_name"].blank?
#    # beginning date
#    shipment_detail = shipment_detail.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
#        unless beginning_date.blank?
#    # end date
#    shipment_detail = shipment_detail.where("products.sold_date <= :date_e", {:date_e => end_date}) \
#        unless end_date.blank?
#    shipment_detail = shipment_detail.reorder('').first
#    bought4 = shipment_detail.amount.to_f
#    bought4_jp = shipment_detail.amount_jp.to_f
#    bought4_cn = shipment_detail.amount_cn.to_f
##        p "bought1=#{bought1}@bought2=#{bought2}@bought3=#{bought3}@bought4=#{bought4}"
#    # sum all
#    cost["amount"] = bought1 + bought2 + bought3 + bought4
#    cost["amount_jp"] = bought1_jp + bought2_jp + bought3_jp + bought4_jp
#    cost["amount_cn"] = bought4_cn
#    return cost
#  end
end
