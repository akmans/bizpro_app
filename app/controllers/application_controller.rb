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
        # page index
        condition["page_ix"] = (par[:page].nil? ? (condition["page_ix"].nil? ? 1 : condition["page_ix"]) : par[:page])
        # category_id
        condition["category_id"] = par[:category_id] unless par[:category_id].nil?
        # auction_name
        condition["auction_name"] = par[:auction_name] unless par[:auction_name].nil?
        # refresh session
        session[:auctions_search_form] = condition
      end
      return condition
    end
end
