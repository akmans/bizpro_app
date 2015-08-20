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
    # product_id
    product = product.where(product_id: condition["product_id"]) unless condition["product_id"].nil?
    # is_domesitc
    product = product.where(is_domestic: condition["is_domestic"]) unless condition["is_domestic"].nil?
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
end
