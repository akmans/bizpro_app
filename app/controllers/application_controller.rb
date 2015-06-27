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

    # remember cashflows search condition
    def refresh_cashflows_search_condition_help(par)
      # new condition hash
      condition = {}
      # refresh condition
      unless par.nil?
        # get previous condition from session
        condition = session[:cashflows_search_form] unless session[:cashflows_search_form].nil?
        # is_in
        condition["is_in"] = par[:is_in] unless par[:is_in].nil?
        # is_auction
        condition["is_auction"] = par[:is_auction] unless par[:is_auction].nil?
        # year start
        condition["year_s"] = par[:year_s] unless par[:year_s].nil?
        # month start
        condition["month_s"] = par[:month_s] unless par[:month_s].nil?
        # year end
        condition["year_e"] = par[:year_e] unless par[:year_e].nil?
        # month end
        condition["month_e"] = par[:month_e] unless par[:month_e].nil?
#        # page index
#        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:cashflows_search_form] = condition
      end
      return condition
    end

    # offshore sold product
    def offshore_sold_product(condition)
      beginning_date = end_date = nil
      # start year month
      if !condition["year_s"].blank? && !condition["month_s"].blank?
        beginning_date = Date::strptime(condition["year_s"] + \
            condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      end
      # end year month
      if !condition["year_e"].blank? && !condition["month_e"].blank?
        end_date = Date::strptime(condition["year_e"] + \
            condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d").end_of_month
      end
      # for return
      info = {}
      # set is_domestic
      info["is_domestic"] = condition["is_domestic"]
      # count product
      info["sold_cnt"] = count_product(condition, beginning_date, end_date)
      # sold data count is 0
      if info["sold_cnt"] == 0 then
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(sold)
        sold = Sold.select("SUM(COALESCE(sold_price, 0))" \
            + " - SUM(COALESCE(ship_charge, 0)) - SUM(COALESCE(other_charge, 0)) as amount") \
            .joins("LEFT JOIN products ON solds.product_id = products.product_id")
        sold = sold.where("products.is_domestic = :is_domestic", \
            is_domestic: condition["is_domestic"]) unless condition["is_domestic"].blank?
        # sold_flg
        sold = sold.where("products.sold_date is null") if condition["sold_flg"] == '0'
        sold = sold.where("products.sold_date is not null") if condition["sold_flg"] == '1'
        # category_id
        sold = sold.where("products.category_id = :category_id", \
            category_id: condition["category_id"]) unless condition["category_id"].blank?
        # product_name
        sold = sold.where("products.product_name like :product_name", \
            {:product_name => "%#{condition['product_name']}%"}) \
            unless condition["product_name"].blank?
        # beginning date
        sold = sold.where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
            unless beginning_date.blank?
        # end date
        sold = sold.where("products.sold_date <= :date_e", {:date_e => end_date}) \
            unless end_date.blank?
        info["sold_amount"] = sold.reorder('').first.amount.to_f
        # amount(bought) git(sold_flg, date_type, is_domestic)
        cost = cost_calculate(condition, beginning_date, end_date)
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
    def domestic_sold_product(condition)
      beginning_date = end_date = nil
      # start year month
      if !condition["year_s"].blank? && !condition["month_s"].blank?
        beginning_date = Date::strptime(condition["year_s"] + \
            condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      end
      # end year month
      if !condition["year_e"].blank? && !condition["month_e"].blank?
        end_date = Date::strptime(condition["year_e"] + \
            condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d").end_of_month
      end
      # for return
      info = {}
      # set is_domestic
      info["is_domestic"] = condition["is_domestic"]
      # count
      info["sold_cnt"] = count_product(condition, beginning_date, end_date)
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
        # sold_flg
        auction = auction.where("products.sold_date is null") if condition["sold_flg"] == '0'
        auction = auction.where("products.sold_date is not null") if condition["sold_flg"] == '1'
        # category_id
        auction = auction.where("products.category_id = :category_id", \
            category_id: condition["category_id"]) unless condition["category_id"].blank?
        # product_name
        auction = auction.where("products.product_name like :product_name", \
            {:product_name => "%#{condition['product_name']}%"}) \
            unless condition["product_name"].blank?
        # beginning date
        auction = auction.where("sold_date >= :date_s", {:date_s => beginning_date}) \
            unless beginning_date.blank?
        # end date
        auction = auction.where("sold_date <= :date_e", {:date_e => end_date}) \
            unless end_date.blank?
        info["sold_amount"] = auction.reorder('').first.amount.to_i
        # amount(bought) (sold_flg, date_type, is_domestic)
        cost = cost_calculate(condition, beginning_date, end_date)
        # cost
        info["cost_amount"] = cost["amount"]
        info["cost_amount_jp"] = cost["amount_jp"]
        info["cost_amount_cn"] = cost["amount_cn"]
#        p "sold_amount=#{info['sold_amount']}@cost_amount=#{info['cost_amount']}"
        # profit amount
        info["profit_amount"] = info["sold_amount"] - info["cost_amount"]
        # profit rate
        info["profit_rate"] = (info["cost_amount"] != 0 ? (info["profit_amount"] * 100 / info["cost_amount"]).round(2) : 0)
      end
      return info
    end
end
