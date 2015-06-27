class CashflowsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # get page index
    page = page_ix_help(params[:page])
    # refresh search condition
    @condition = refresh_cashflows_search_condition_help(params)
    # get custom data.
    @cashflows = search_cashflow(@condition, page)
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
    @condition = refresh_cashflows_search_condition_help(params)
    # get cashflow data list with pagination.
    @cashflows = search_cashflow(@condition, 1)
    # render index page
    render 'index'
  end

  private
    # search cashflow
    def search_cashflow(condition, page_ix)
      # construct where condition
      cashflow = Cashflow
      # is_in
      cashflow = cashflow.where(is_in: condition["is_in"].to_i) \
                 unless condition["is_in"].blank?
      # is_auction
      cashflow = cashflow.where(is_auction: condition["is_auction"].to_i) \
                 unless condition["is_auction"].blank?
      # start year month
      if !condition["year_s"].blank? && !condition["month_s"].blank?
        date_s = Date::strptime(condition["year_s"] + condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
        cashflow = cashflow.where("happen_date >= :created_at", {:created_at => date_s})
      end
      # end year month
      if !condition["year_e"].blank? && !condition["month_e"].blank?
        date_e = Date::strptime(condition["year_e"] + condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d")
        cashflow = cashflow.where("happen_date <= :created_at", {:created_at => date_e.end_of_month})
      end
      # paginate
      cashflow.paginate(page: page_ix, per_page: 15)
    end
end