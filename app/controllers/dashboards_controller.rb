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
    @summary["offshore"] = offshore_sold_info
    # by date
    @summary["auction"] = auction_info
    @summary["custom"] = custom_info
    @summary["shipment"] = shipment_info
    # undeal
    @summary["undeal_product"] = undeal_product_info
    @summary["undeal_auction"] = undeal_auction_info
    @summary["undeal_custom"] = undeal_custom_info
    @summary["shipment_status"] = shipment_status_info
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
    # get offshore sold data info
    def offshore_sold_info
      t = Time.now
      offshore = {}
      # all--------------------------
      condition = {"is_domestic" => 0}
      # all data
      all = offshore_sold_product(condition)
      offshore["sold_all_cnt"] = all["sold_cnt"]
      offshore["sold_all_amount"] = all["sold_amount"]
      offshore["sold_all_profit"] = all["profit_amount"]
      offshore["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      condition = {"is_domestic" => 0, "year_s" => t.strftime("%Y"), \
          "month_s" => 1, "year_e" => t.strftime("%Y"), "month_e" => 12
      }
      # data of current year
      year = offshore_sold_product(condition)
      offshore["sold_year_cnt"] = year["sold_cnt"]
      offshore["sold_year_amount"] = year["sold_amount"]
      offshore["sold_year_profit"] = year["profit_amount"]
      offshore["sold_year_profit_rate"] = year["profit_rate"]
      # month--------------------------
      condition = {"is_domestic" => 0, "year_s" => t.strftime("%Y"), \
          "month_s" => t.strftime("%m"), "year_e" => t.strftime("%Y"), \
          "month_e" => t.strftime("%m")
      }
      # data of current month
      month = offshore_sold_product(condition)
      offshore["sold_month_cnt"] = month["sold_cnt"]
      offshore["sold_month_amount"] = month["sold_amount"]
      offshore["sold_month_profit"] = month["profit_amount"]
      offshore["sold_month_profit_rate"] = month["profit_rate"]
      return offshore
    end

    # get domesitc sold data info
    def domestic_sold_info
      t = Time.now
      domestic = {}
      # all--------------------------
      condition = {"is_domestic" => 1}
      # all data
      all = domestic_sold_product(condition)
      domestic["sold_all_cnt"] = all["sold_cnt"]
      domestic["sold_all_amount"] = all["sold_amount"]
      domestic["sold_all_profit"] = all["profit_amount"]
      domestic["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      condition = {"is_domestic" => 1, "year_s" => t.strftime("%Y"), \
          "month_s" => 1, "year_e" => t.strftime("%Y"), "month_e" => 12
      }
      # data of current year
      year = domestic_sold_product(condition)
      domestic["sold_year_cnt"] = year["sold_cnt"]
      domestic["sold_year_amount"] = year["sold_amount"]
      domestic["sold_year_profit"] = year["profit_amount"]
      domestic["sold_year_profit_rate"] = year["profit_rate"]
      # month--------------------------
      condition = {"is_domestic" => 1, "year_s" => t.strftime("%Y"), \
          "month_s" => t.strftime("%m"), "year_e" => t.strftime("%Y"), \
          "month_e" => t.strftime("%m")
      }
      # data of current month
      month = offshore_sold_product(condition)
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

    # get shipment data info
    def shipment_info
      shipment = {}
      # shipment sending all
      shipment["shipment_sending_all"] = count_shipment(0, 0)
      # shipment sending year
      shipment["shipment_sending_year"] = count_shipment(0, 1)
      # shipment sending month
      shipment["shipment_sending_month"] = count_shipment(0, 2)
      # shipment arrived all
      shipment["shipment_arrived_all"] = count_shipment(1, 0)
      # shipment arrived year
      shipment["shipment_arrived_year"] = count_shipment(1, 1)
      # shipment arrived month
      shipment["shipment_arrived_month"] = count_shipment(1, 2)
      return shipment
    end

    # get undeal product data info
    def undeal_product_info
      product = {}
      # total 
      product["domesitc_cnt"] = Product.where(is_domestic: 1).count
      product["domestic_no_cost_cnt"] = Product \
          .joins("LEFT OUTER JOIN (SELECT pa_maps.product_id FROM auctions " \
          + " LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id " \
          + " AND auctions.sold_flg = 0) ap ON products.product_id = ap.product_id" ) \
          .joins("LEFT OUTER JOIN (SELECT pc_maps.product_id FROM customs " \
          + " LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id) as cp " \
          + " ON products.product_id = cp.product_id") \
          .where("ap.product_id is null and cp.product_id is null") \
          .where.not(sold_date: nil).count
      # domesitc sold count
      product["domesitc_sold_cnt"] = Product.where(is_domestic: 1).where.not(sold_date: nil).count \
          - product["domestic_no_cost_cnt"]
      # domesitc unsale count
      product["domesitc_unsale_cnt"] = product["domesitc_cnt"].to_i \
          - product["domesitc_sold_cnt"].to_i - product["domestic_no_cost_cnt"].to_i
      # offshore sending count
      product["offshore_sending_cnt"] = Product.where(is_domestic: 2).count
      # offshore sold count
      product["offshore_sold_cnt"] = Product.where(is_domestic: 0).where.not(sold_date: nil).count
      # offshore unsale count
      product["offshore_unsale_cnt"] = Product.where(is_domestic: 0).where(sold_date: nil).count
      return product
    end

    # get undeal auction data info
    def undeal_auction_info
      auction = {}
      # ope_flg is null
      auction["operation_unregist"] = Auction.where("ope_flg IS NULL").count
      # product unregirst
      auction["product_unregist"] =  Auction \
          .joins("LEFT OUTER JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id") \
          .where("pa_maps.product_id is null").where(ope_flg: 1).count
      # custom unregirst
      allCustom = Auction.where(ope_flg: 0).count
      # regirsted custom count
      finishCustom = Custom.select("auction_id, SUM(percentage)")\
          .where("auction_id is not null").reorder('').group("auction_id") \
          .having("SUM(percentage) = 100").pluck(:auction_id).count
      # unregirst custom count
      auction["custom_unregist"] = allCustom - finishCustom
      return auction
    end

    # get undeal custom data info
    def undeal_custom_info
      custom = {}
      # product unregist
      custom["product_unregist"] =  Custom \
          .joins("LEFT OUTER JOIN pc_maps ON pc_maps.custom_id = customs.custom_id") \
          .where("pc_maps.product_id is null").count
      return custom
    end

    # get shipment status info
    def shipment_status_info
      shipment = {}
      # shipment sending
      shipment["sending"] = Shipment.where(arrived_date: nil).count
      # shipment sending
      shipment["arrived"] = Shipment.where.not(arrived_date: nil).count
      return shipment
    end

    # ---------------------- utilities function(LEVEL 1) --------------------------
    # count auction(date_type 0:all 1:year 2:month)
    def count_auction(sold_flg, date_type)
      # all
      return Auction.where(sold_flg: sold_flg).all.count if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return Auction.where(sold_flg: sold_flg) \
          .where("end_time >= :date_s", {:date_s => beginning_date}) \
          .where("end_time <= :date_e", {:date_e => end_date}).all.count
    end

    # sum auction(date_type 0:all 1:year 2:month)
    def sum_auction(sold_flg, date_type)
      # all
      return Auction.select("SUM(price * (tax_rate + 100) / 100 + " \
          + "COALESCE(payment_cost, 0) + COALESCE(shipment_cost, 0)) as amount") \
          .where(sold_flg: sold_flg).reorder('').first.amount.to_i if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return Auction.select("SUM(price * (tax_rate + 100) / 100 + " \
          + "COALESCE(payment_cost, 0) + COALESCE(shipment_cost, 0)) as amount") \
          .where(sold_flg: sold_flg) \
          .where("end_time >= :date_s", {:date_s => beginning_date}) \
          .where("end_time <= :date_e", {:date_e => end_date}).reorder('').first.amount.to_i
    end

    # count custom(date_type 0:all 1:year 2:month)
    def count_custom(is_auction, date_type)
      # all
      return Custom.where(is_auction: is_auction).all.count if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return Custom.where(is_auction: is_auction) \
          .where("created_at >= :date_s", {:date_s => beginning_date}) \
          .where("created_at <= :date_e", {:date_e => end_date}).all.count
    end

    # count shipment(date_type 0:all 1:year 2:month)
    def count_shipment(date_flg, date_type)
      # all
      return Shipment.all.count if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # shipment sending
      count = Shipment.where("shipments.sent_date >= :date_s", {:date_s => beginning_date}) \
          .where("shipments.sent_date <= :date_e", {:date_e => end_date}).all.count \
          if date_flg == 0
      # shipment arrived
      count = Shipment.where("shipments.arrived_date >= :date_s", {:date_s => beginning_date}) \
          .where("shipments.arrived_date <= :date_e", {:date_e => end_date}).all.count \
          if date_flg == 1
      return count
    end

end
