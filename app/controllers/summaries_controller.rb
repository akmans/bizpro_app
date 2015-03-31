class SummariesController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # refresh search condition
    @condition = refresh_summaries_search_condition_help(params)
    # default is domesitc
    @condition["is_domestic"] = '1' if @condition["is_domestic"].blank?
    # get product data.
    @products = search_summary(@condition)
#    date_s = Date::strptime(@condition["year_s"] + \
#        @condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d") \
#        unless (@condition["year_s"].blank? && @condition["month_s"].blank?)
#    date_e = Date::strptime(@condition["year_e"] + \
#        @condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d") \
#        unless (@condition["year_e"].blank? && @condition["month_e"].blank?)
    @summary = domestic_sold_product(@condition) if @condition["is_domestic"] == '1'
    @summary = offshore_sold_product(@condition) if @condition["is_domestic"] != '1'
  end

  # show action
  # nil

  # new action
  # nil

  # create action
  # nil

  # edit action
  # nil

  # update action
  # nil

  # destroy action
  # nil

  # search action
  def search
    # get parameters from params and save it into session
    @condition = refresh_summaries_search_condition_help(params)
    # get product data list with pagination.
    @products = search_summary(@condition)
#    date_s = Date::strptime(@condition["year_s"] + \
#        @condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d") \
#        unless (@condition["year_s"].blank? && @condition["month_s"].blank?)
#    date_e = Date::strptime(@condition["year_e"] + \
#        @condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d") \
#        unless (@condition["year_e"].blank? && @condition["month_e"].blank?)
    @summary = domestic_sold_product(@condition) if @condition["is_domestic"] == '1'
    @summary = offshore_sold_product(@condition) if @condition["is_domestic"] != '1'
    # render index page
    render 'index'
  end

  private
  # search summary
  def search_summary(condition)
    # construct where condition
    product = Product
#    # no_cost
#    product = product.joins("LEFT OUTER JOIN (SELECT DISTINCT pa_maps.product_id FROM auctions " \
#        + " LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id " \
#        + " AND auctions.sold_flg = 0) ap ON products.product_id = ap.product_id" ) \
#        .joins("LEFT OUTER JOIN (SELECT DISTINCT pc_maps.product_id FROM customs " \
#        + " LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id) as cp " \
#        + " ON products.product_id = cp.product_id") \
#        .where.not(sold_date: nil) if condition["no_cost"] == '1' || condition["no_cost"] == '0'
#    # no_cost = 1
#    product = product.where("ap.product_id is null and cp.product_id is null") if condition["no_cost"] == '1'
#    # no_cost = 0
#    product = product.where("ap.product_id is not null or cp.product_id is not null") if condition["no_cost"] == '0'
    # category_id
    product = product.where(category_id: condition["category_id"]) \
              unless condition["category_id"].blank?
    # product_name
    product = product.where("product_name like :product_name", \
              {:product_name => "%#{condition['product_name']}%"}) \
              unless condition["product_name"].blank?
    # start year month
    if !condition["year_s"].blank? && !condition["month_s"].blank? && !condition["is_domestic"].blank?
      date_s = Date::strptime(condition["year_s"] + condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      # condition for offshore
      product = product.where(product_id: Sold.where("sold_date >= :sold_date", \
                {:sold_date => date_s}).pluck(:product_id)) \
                if condition["is_domestic"] == "0"
      # condition for domestic
      product = product.where(product_id: PaMap.where(auction_id: Auction.where("end_time >= :end_time", \
                {:end_time => date_s}).pluck(:auction_id)).pluck(:product_id)) \
                if condition["is_domestic"] == "1"
    end
    # end year month
    if !condition["year_e"].blank? && !condition["month_e"].blank? && !condition["is_domestic"].blank?
      date_e = Date::strptime(condition["year_e"] + condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      # condition for offshore
      product = product.where(product_id: Sold.where("sold_date <= :sold_date", \
                {:sold_date => date_e.end_of_month}).pluck(:product_id))\
                if condition["is_domestic"] == "0"
      # condition for domestic
      product = product.where(product_id: PaMap.where(auction_id: Auction.where("end_time <= :end_time", \
                {:end_time => date_e.end_of_month}).pluck(:auction_id)).pluck(:product_id)) \
                if condition["is_domestic"] == "1"
    end
    # is_domestic
    product = product.where(is_domestic: condition["is_domestic"]) \
              unless condition["is_domestic"].blank?
    # sold_flg
    product = product.where(sold_date: nil) if condition["sold_flg"] == '0'
    product = product.where.not(sold_date: nil) if condition["sold_flg"] == '1'
    return product.all
#    # paginate
#    product.paginate(page: page_ix, per_page: 15)
  end
end