class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper, ApplicationHelper, CustomsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in_help?
        store_location_help
        flash.now[:danger] = "Please log in."
        render :partial => '/shared/ajax_message' if request.xhr?
        redirect_to login_url unless request.xhr?
      end
    end

    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    # remember page index
    def page_ix_help(page)
      return (session[:page_ix] = page) unless page.nil?
      return session[:page_ix] unless session[:page_ix].nil?
      return 1
    end

    # remember auctions search condition
    def refresh_auctions_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:auctions_search_form] unless session[:auctions_search_form].nil?
        # category_id
        condition["category_id"] = par[:category_id] unless par[:category_id].nil?
        # auction_name
        condition["auction_name"] = par[:auction_name] unless par[:auction_name].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
        # sold type
        condition["sold_type"] = par[:sold_type] unless par[:sold_type].nil?
        # undeal auction
        condition["undeal_auction"] = par[:undeal_auction] unless par[:undeal_auction].nil?
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:auctions_search_form] = condition
      end
      return condition
    end

    # remember products search condition
    def refresh_products_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:products_search_form] unless session[:products_search_form].nil?
        # category_id
        condition["category_id"] = par[:category_id] unless par[:category_id].nil?
        # product_name
        condition["product_name"] = par[:product_name] unless par[:product_name].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
        # is_domestic
        condition["is_domestic"] = par[:is_domestic] unless par[:is_domestic].nil?
        # sold_flg
        condition["sold_flg"] = par[:sold_flg] unless par[:sold_flg].nil?
        # no_cost
        condition["no_cost"] = (par[:no_cost].nil? ? '' : par[:no_cost] )
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:products_search_form] = condition
      end
      return condition
    end

    # remember customs search condition
    def refresh_customs_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:customs_search_form] unless session[:customs_search_form].nil?
        # custom_name
        condition["custom_name"] = par[:custom_name] unless par[:custom_name].nil?
        # is_auction
        condition["is_auction"] = par[:is_auction] unless par[:is_auction].nil?
        # product_regist
        condition["product_unregist"] = par[:product_unregist] unless par[:product_unregist].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
        # auction_id
        condition["auction_id"] = par[:auction_id] unless par[:auction_id].nil?
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:customs_search_form] = condition
      end
      return condition
    end

    # remember shipments search condition
    def refresh_shipments_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:shipments_search_form] unless session[:shipments_search_form].nil?
        # shipmethod_id
        condition["shipmethod_id"] = par[:shipmethod_id] unless par[:shipmethod_id].nil?
        # product_name
        condition["product_name"] = par[:product_name] unless par[:product_name].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
        # date_type
        condition["date_type"] = par[:date_type] unless par[:date_type].nil?
        # shipment_status
        condition["shipment_status"] = par[:shipment_status] unless par[:shipment_status].nil?
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:shipments_search_form] = condition
      end
      return condition
    end

    # remember summaries search condition
    def refresh_summaries_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:summaries_search_form] unless session[:summaries_search_form].nil?
        # category_id
        condition["category_id"] = par[:category_id] unless par[:category_id].nil?
        # product_name
        condition["product_name"] = par[:product_name] unless par[:product_name].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
        # is_domestic
        condition["is_domestic"] = par[:is_domestic] unless par[:is_domestic].nil?
        # sold_flg
        condition["sold_flg"] = par[:sold_flg] unless par[:sold_flg].nil?
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:summaries_search_form] = condition
      end
      return condition
    end

    # offshore sold product
    def offshore_sold_product(date_type, beginning_date, end_date)
      info = {}
      # count product
      info["sold_cnt"] = count_product(0, beginning_date, end_date)
      # sold data count is 0
      if info["sold_cnt"] == 0 then
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(sold)
        sold = Sold.select("SUM(COALESCE(sold_price, 0))" \
            + " - SUM(COALESCE(ship_charge, 0)) - SUM(COALESCE(other_charge, 0)) as amount") \
            .joins("LEFT JOIN products ON solds.product_id = products.product_id") \
            .where("products.is_domestic = 0")
        # beginning date
        sold = sold.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
            unless beginning_date.blank?
        # end date
        sold = sold.where("products.sold_date <= :date_e", {:date_e => end_date}) \
            unless end_date.blank?
        info["sold_amount"] = sold.reorder('').first.amount
        # amount(bought) git(sold_flg, date_type, is_domestic)
        cost = cost_calculate(0, beginning_date, end_date)
        # cost
        info["cost_amount"] = cost["amount"]
        info["cost_amount_jp"] = cost["amount_jp"]
        info["cost_amount_cn"] = cost["amount_cn"]
        # profit amount
        info["profit_amount"] = info["sold_amount"] - info["cost_amount"]
        # profit rate
        info["profit_rate"] = (info["cost_amount"] != 0 ? (info["profit_amount"] * 100 / info["cost_amount"]).round(2) : 0)
      end
      return info
    end

    # domestic sold product
    def domestic_sold_product(date_type, beginning_date, end_date)
      info = {}
      # count
      info["sold_cnt"] = count_product(1, beginning_date, end_date)
      # sold data count is 0
      if info["sold_cnt"] == 0 then
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(sold)
        auction = Auction.select("SUM(price * (tax_rate + 100) / 100 - " \
            + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) as amount") \
            .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
            .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
            .where("products.is_domestic = 1").where(sold_flg: 1)
        # beginning date
        auction = auction.where("sold_date >= :date_s", {:date_s => beginning_date}) \
            unless beginning_date.blank?
        # end date
        auction = auction.where("sold_date <= :date_e", {:date_e => end_date}) \
            unless end_date.blank?
        info["sold_amount"] = auction.reorder('').first.amount.to_i
        # amount(bought) (sold_flg, date_type, is_domestic)
        cost = cost_calculate(1, beginning_date, end_date)
        # cost
        info["cost_amount"] = cost["amount"]
        info["cost_amount_jp"] = cost["amount_jp"]
        info["cost_amount_cn"] = cost["amount_cn"]
        # profit amount
        info["profit_amount"] = info["sold_amount"] - info["cost_amount"]
        # profit rate
        info["profit_rate"] = (info["cost_amount"] != 0 ? (info["profit_amount"] * 100 / info["cost_amount"]).round(2) : 0)
      end
      return info
    end

    # ---------------------- utilities function(LEVEL 1) --------------------------
    # count product
    def count_product(is_domestic, beginning_date, end_date)
      # all
      product = Product.where(is_domestic: is_domestic).where.not(sold_date: nil)
      # beginning date
      product = product.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          unless beginning_date.blank?
      # end date
      product = product.where("products.sold_date <= :date_e", {:date_e => end_date}) \
          unless end_date.blank?
      # year or month
      return product.count
    end

    # cost calculate(date_type 0:all 1:year 2:month)
    def cost_calculate(is_domestic, beginning_date, end_date)
      cost = {}
      # auction cost------------------------------
      auction = Auction.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount, " \
          + "SUM(price * (tax_rate + 100) / 100 - COALESCE(payment_cost, 0) - " \
          + "COALESCE(shipment_cost, 0)) as amount_jp") \
          .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null").where(sold_flg: 0)
      # beginning date
      auction = auction.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          unless beginning_date.blank?
      # end date
      auction = auction.where("products.sold_date <= :date_e", {:date_e => end_date}) \
          unless end_date.blank?
      auction = auction.reorder('').first
      bought1 = auction.amount.to_f
      bought1_jp = auction.amount_jp.to_f
      # custom cost(non auction)------------------------------
      custom = Custom.select("SUM((COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount, " \
          + "SUM(COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) as amount_jp") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null").where(is_auction: 0)
      # beginning date
      custom = custom.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          unless beginning_date.blank?
      # end date
      custom = custom.where("products.sold_date <= :date_e", {:date_e => end_date}) \
          unless end_date.blank?
      custom = custom.reorder('').first
      bought2 = custom.amount.to_f
      bought2_jp = custom.amount_jp.to_f
      # custom cost(auction)------------------------------
      custom2 = Custom.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) * " \
          + "percentage / 100 / 100) as amount, " \
          + "SUM((price * (tax_rate + 100) / 100 - COALESCE(payment_cost, 0) - " \
          + "COALESCE(shipment_cost, 0)) * percentage / 100) as amount_jp") \
          .joins("LEFT JOIN auctions ON customs.auction_id = auctions.auction_id ") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null").where(is_auction: 1)
      # beginning date
      custom2 = custom2.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          unless beginning_date.blank?
      # end date
      custom2 = custom2.where("products.sold_date <= :date_e", {:date_e => end_date}) \
          unless end_date.blank?
      custom2 = custom2.reorder('').first
      bought3 = custom2.amount.to_f
      bought3_jp = custom2.amount_jp.to_f
      # offshore shipment cost------------------------------
      shipment_detail = ShipmentDetail.select("SUM((COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0) + " \
          + "COALESCE(custom_cost, 0) * 100 / (CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) " \
          + ") * ((CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100)) as amount, " \
          + "SUM(COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0)) as amount_jp, " \
          + "SUM(COALESCE(custom_cost, 0)) as amount_cn") \
          .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null")
      # beginning date
      shipment_detail = shipment_detail.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          unless beginning_date.blank?
      # end date
      shipment_detail = shipment_detail.where("products.sold_date <= :date_e", {:date_e => end_date}) \
          unless end_date.blank?
      shipment_detail = shipment_detail.reorder('').first
      bought4 = shipment_detail.amount.to_f
      bought4_jp = shipment_detail.amount_jp.to_f
      bought4_cn = shipment_detail.amount_cn.to_f
      # sum all
      cost["amount"] = bought1 + bought2 + bought3 + bought4
      cost["amount_jp"] = bought1_jp + bought2_jp + bought3_jp + bought4_jp
      cost["amount_cn"] = bought4_cn
      return cost
    end
end
