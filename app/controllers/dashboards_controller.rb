#encoding: utf-8
class DashboardsController < ApplicationController
  before_action :logged_in_user

  # index action
  # nil

  # show action
  def show
    @summary = {}
    # sell info
    @summary["domestic"] = domestic_sold_info
    # undeal
    @summary["undeal_product"] = undeal_product_info
    @summary["undeal_auction"] = undeal_auction_info
    @summary["undeal_custom"] = undeal_custom_info
    # by date
    @summary["auction"] = auction_info
    @summary["custom"] = custom_info
#    debugger
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
    # get domesitc sold data info
    def domestic_sold_info
      domestic = {}
      # all
      all = domestic_sold_product(0)
      domestic["sold_all_cnt"] = all["sold_cnt"]
      domestic["sold_all_amount"] = all["sold_amount"]
      domestic["sold_all_profit"] = all["profit_amount"]
      domestic["sold_all_profit_rate"] = all["profit_rate"]
      # year
      year = domestic_sold_product(1)
      domestic["sold_year_cnt"] = year["sold_cnt"]
      domestic["sold_year_amount"] = year["sold_amount"]
      domestic["sold_year_profit"] = year["profit_amount"]
      domestic["sold_year_profit_rate"] = year["profit_rate"]
      # month
      month = domestic_sold_product(2)
      domestic["sold_month_cnt"] = month["sold_cnt"]
      domestic["sold_month_amount"] = month["sold_amount"]
      domestic["sold_month_profit"] = month["profit_amount"]
      domestic["sold_month_profit_rate"] = month["profit_rate"]
      return domestic
    end

    # get auction data info
    def auction_info
      auction = {}
      # ------------- sold data --------------------
      # all auction data(sold)
      auction["sold_all_cnt"] = count_auction(1, 0)
      auction["sold_all_amount"] = sum_auction(1, 0)
      # auction data of current year(sold)
      auction["sold_year_cnt"] = count_auction(1, 1)
      auction["sold_year_amount"] = sum_auction(1, 1)
      # auction date of current month(sold)
      auction["sold_month_cnt"] = count_auction(1, 2)
      auction["sold_month_amount"] = sum_auction(1, 2)
      # ------------- bought data --------------------
      # all auction data(bought)
      auction["bought_all_cnt"] = count_auction(0, 0)
      auction["bought_all_amount"] = sum_auction(0, 0)
      # auction data of current year(bought)
      auction["bought_year_cnt"] = count_auction(0, 1)
      auction["bought_year_amount"] = sum_auction(0, 1)
      # auction date of current month(bought)
      auction["bought_month_cnt"] = count_auction(0, 2)
      auction["bought_month_amount"] = sum_auction(0, 2)
      return auction
    end

    # get custom data info
    def custom_info
      custom = {}
      # --------- auction data --------------------
      # all custom data(is_auction)
      custom["auction_all"] = count_custom(1, 0)
      # custom data of current year(is_auction)
      custom["auction_year"] = count_custom(1, 1)
      # custom date of current month(is_auction)
      custom["auction_month"] = count_custom(1, 2)
      # --------- general data --------------------
      # all custom data(general)
      custom["general_all"] = count_custom(0, 0)
      # custom data of current year(general)
      custom["general_year"] = count_custom(0, 1)
      # custom date of current month(general)
      custom["general_month"] = count_custom(0, 2)
      return custom
    end

    # get undeal product data info
    def undeal_product_info
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
      return auction
    end

    # get undeal custom data info
    def undeal_custom_info
      custom = {}
      # product unregist
      custom["product_unregist"] = Custom.where.not(custom_id: PcMap.all.pluck(:custom_id)).count
      return custom
    end

    # ---------------------- utilities function --------------------------
    # domestic sold product
    def domestic_sold_product(date_type)
      info = {}
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # count
      info["sold_cnt"] = Auction.joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .where(sold_flg: 1).count if date_type == 0
      info["sold_cnt"] = Auction.joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .where(sold_flg: 1).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).count if date_type != 0
      # amount(sold)
      info["sold_amount"] = Auction.select("SUM(price) as amount").joins("LEFT JOIN pa_maps" \
          + " ON auctions.auction_id = pa_maps.auction_id ").where(sold_flg: 1).first.amount if date_type == 0
      info["sold_amount"] = Auction.select("SUM(price) as amount").joins("LEFT JOIN pa_maps" \
          + " ON auctions.auction_id = pa_maps.auction_id ").where(sold_flg: 1).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount if date_type != 0
      # amount(bought)
      bought1 = Auction.select("SUM(price) as amount").joins("LEFT JOIN pa_maps" \
          + " ON auctions.auction_id = pa_maps.auction_id ").where(sold_flg: 0).first.amount.to_i if date_type == 0
      bought1 = Auction.select("SUM(price) as amount").joins("LEFT JOIN pa_maps" \
          + " ON auctions.auction_id = pa_maps.auction_id ").where(sold_flg: 0).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount.to_i if date_type != 0
      bought2 = Custom.select("SUM(net_cost) + SUM(tax_cost) + SUM(other_cost) as amount").joins("LEFT JOIN pc_maps" \
          + " ON customs.custom_id = pc_maps.custom_id ").joins("LEFT JOIN products" \
          + " ON pc_maps.product_id = products.product_id ").joins("LEFT JOIN pa_maps" \
          + " ON products.product_id = pa_maps.product_id").joins("LEFT JOIN auctions" \
          + " ON pa_maps.auction_id = auctions.auction_id").where(is_auction: 0).first.amount.to_i if date_type == 0
      bought2 = Custom.select("SUM(net_cost) + SUM(tax_cost) + SUM(other_cost) as amount").joins("LEFT JOIN pc_maps" \
          + " ON customs.custom_id = pc_maps.custom_id ").joins("LEFT JOIN products" \
          + " ON pc_maps.product_id = products.product_id ").joins("LEFT JOIN pa_maps" \
          + " ON products.product_id = pa_maps.product_id").joins("LEFT JOIN auctions" \
          + " ON pa_maps.auction_id = auctions.auction_id").where(is_auction: 0).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount.to_i if date_type != 0
      bought3 = Custom.select("SUM(price * percentage) as amount").joins("LEFT JOIN auctions" \
          + " ON customs.auction_id = auctions.auction_id ").joins("LEFT JOIN pc_maps" \
          + " ON customs.custom_id = pc_maps.custom_id ").where(is_auction: 1).first.amount.to_i if date_type == 0
      bought3 = Custom.select("SUM(price * percentage) as amount").joins("LEFT JOIN auctions" \
          + " ON customs.auction_id = auctions.auction_id ").joins("LEFT JOIN pc_maps" \
          + " ON customs.custom_id = pc_maps.custom_id ").where(is_auction: 1).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount.to_i if date_type != 0
      bought4 = ShipmentDetail.select("SUM(ship_cost) + SUM(insured_cost) + SUM(custom_cost * exchange_rate) as amount") \
          .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
          .joins("LEFT JOIN pa_maps ON products.product_id = pa_maps.product_id") \
          .joins("LEFT JOIN auctions ON pa_maps.auction_id = auctions.auction_id") \
          .where("sold_flg = :sold_flg", :sold_flg => 0).first.amount.to_i if date_type == 0
      bought4 = ShipmentDetail.select("SUM(ship_cost) + SUM(insured_cost) + SUM(custom_cost * exchange_rate) as amount") \
          .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
          .joins("LEFT JOIN pa_maps ON products.product_id = pa_maps.product_id") \
          .joins("LEFT JOIN auctions ON pa_maps.auction_id = auctions.auction_id") \
          .where("sold_flg = :sold_flg", :sold_flg => 0).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount.to_i if date_type != 0
#      debugger
      # profit amount
      info["profit_amount"] = info["sold_amount"] - bought1 - bought2 - bought3 - bought4
      # profit rate
      info["profit_rate"] = (info["profit_amount"] * 100 / (bought1 + bought2 + bought3 + bought4)).round(2)
      return info
    end

    # count auction(date_type 0:all 1:year 2:month)
    def count_auction(sold_flg, date_type)
      return Auction.where(sold_flg: sold_flg).all.count if date_type == 0
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      return Auction.where(sold_flg: 1).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).all.count
    end

    # sum auction(date_type 0:all 1:year 2:month)
    def sum_auction(sold_flg, date_type)
      return Auction.select("SUM(price) as amount").where(sold_flg: sold_flg).first.amount.to_i if date_type == 0
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      return Auction.select("SUM(price) as amount").where(sold_flg: sold_flg).where("end_time >= :date_s", \
          {:date_s => beginning_date}).where("end_time <= :date_e", \
          {:date_e => end_date}).first.amount.to_i
    end

    # count custom(date_type 0:all 1:year 2:month)
    def count_custom(is_auction, date_type)
      return Custom.where(is_auction: is_auction).all.count if date_type == 0
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      return Custom.where(is_auction: is_auction).where("created_at >= :date_s", \
          {:date_s => beginning_date}).where("created_at <= :date_e", \
          {:date_e => end_date}).all.count
    end
end
