#encoding: utf-8
class DashboardsController < ApplicationController
  before_action :logged_in_user

  # index action
  # nil

  # show action
  def show
    @summary = {}
    @summary["product"] = product_info
    
    render 'dashboard'
  end

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

  private
    # get product data info
    def product_info
      product = {}
      # total 
      product["domesitc_cnt"] = Product.where(is_domestic: 1).count
      # domesitc sold count
      product["domesitc_sold_cnt"] = Product.where(is_domestic: 1).where(product_id: \
          PaMap.where(auction_id: Auction.where(sold_flg: 1).pluck(:auction_id)).pluck(:product_id)).count
      # domesitc unsale count
      product["domesitc_unsale_cnt"] = product["domesitc_cnt"].to_i - product["domesitc_sold_cnt"].to_i
      # offshore sending count
      product["offshore_sending_cnt"] = Product.where(is_domestic: 2).count
      # offshore sold count
      product["offshore_sold_cnt"] = Product.where(is_domestic: 0).where(product_id: Sold.all.pluck(:product_id)).count
      # offshore unsale count
      product["offshore_unsale_cnt"] = Product.where(is_domestic: 0).count - product["offshore_sold_cnt"]
      return product
    end
end
