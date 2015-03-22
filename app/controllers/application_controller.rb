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
        # page index
        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
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
        # page index
        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # refresh session
        session[:shipments_search_form] = condition
      end
      return condition
    end
end
