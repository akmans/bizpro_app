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

    # get undeal auction data info
    def undeal_auction_info
      auction = {}
      # ope_flg is null
      auction["operation_unregist"] = Auction.where("ope_flg IS NULL").count
      # product unregirst
      auction["product_unregist"] =  Auction.joins("LEFT OUTER JOIN pa_maps" \
          + " ON auctions.auction_id = pa_maps.auction_id and pa_maps.product_id is null ").where(ope_flg: 1).count
      # custom unregirst
      allCustom = Auction.where(ope_flg: 0).count
      finishCustom = Auction.where(auction_id: Custom.select("auction_id, SUM(percentage)")\
          .where("auction_id is not null").group("auction_id").having("SUM(percentage) = 100").pluck(:auction_id)).count
      auction["custom_unregist"] = allCustom - finishCustom
    end
end
