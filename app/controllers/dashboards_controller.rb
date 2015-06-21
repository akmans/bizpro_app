#encoding: utf-8
class DashboardsController < ApplicationController
  before_action :logged_in_user

  # index action
  # nil

  # show action
  def show
    @summary = {}
    # cash flow info
    @summary["cash_flow_domestic"] = domestic_cash_flow_info
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
    # domestic_cash_flow_info function
    def domestic_cash_flow_info
      domestic = {}
      # all (sold_flg: 0-bought, data_type: 0-all, domestic_flg: 1-domestic)
      all_bought_auction = sum_auction(0, 0, 1)
      # all (is_auction: 0-not auction, data_type: 0-all)
      all_bought_custom = sum_custom(0, 0, 2)
      domestic["bought_all_amount"] = all_bought_auction + all_bought_custom
      # year (sold_flg: 0-bought, data_type: 1-year, domestic_flg: 1-domestic)
      year_bought_auction = sum_auction(0, 1, 1)
      # year (is_auction: 0-not auction, data_type: 1-year)
      year_bought_custom = sum_custom(0, 1, 2)
      domestic["bought_year_amount"] = year_bought_auction + year_bought_custom
      # month (sold_flg: 0-bought, data_type: 2-month, domestic_flg: 1-domestic)
      month_bought_auction = sum_auction(0, 2, 1)
      # month (is_auction: 0-not auction, data_type: 2-month)
      month_bought_custom = sum_custom(0, 2, 2)
      domestic["bought_month_amount"] = month_bought_auction + month_bought_custom
      # all (sold_flg: 1-sold, data_type: 0-all, domestic_flg: 1-domestic)
      all_sold_auction = sum_auction(1, 0, 1)
      domestic["sold_all_amount"] = all_sold_auction
      # year (sold_flg: 1-sold, data_type: 1-year, domestic_flg: 1-domestic)
      year_sold_auction = sum_auction(1, 1, 1)
      domestic["sold_year_amount"] = year_sold_auction
      # month (sold_flg: 1-sold, data_type: 2-month, domestic_flg: 1-domestic)
      month_sold_auction = sum_auction(1, 2, 1)
      domestic["sold_month_amount"] = month_sold_auction
      return domestic
    end

    # offshore_sold_info function
    def offshore_sold_info
      t = Time.now
      offshore = {}
      # all--------------------------
      condition = {"is_domestic" => 0, "sold_flg" => '1'}
      # all data
      all = offshore_sold_product(condition)
      offshore["sold_all_cnt"] = all["sold_cnt"]
      offshore["sold_all_amount"] = all["sold_amount"]
      offshore["sold_all_profit"] = all["profit_amount"]
      offshore["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      condition = {"is_domestic" => 0, "year_s" => t.strftime("%Y"),
          "month_s" => 1, "year_e" => t.strftime("%Y"), "month_e" => 12,
          "sold_flg" => '1'
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
          "month_e" => t.strftime("%m"), "sold_flg" => '1'
      }
      # data of current month
      month = offshore_sold_product(condition)
      offshore["sold_month_cnt"] = month["sold_cnt"]
      offshore["sold_month_amount"] = month["sold_amount"]
      offshore["sold_month_profit"] = month["profit_amount"]
      offshore["sold_month_profit_rate"] = month["profit_rate"]
      return offshore
    end

    # domesitc_sold_info function
    def domestic_sold_info
      t = Time.now
      domestic = {}
      # all--------------------------
      condition = {"is_domestic" => 1, "sold_flg" => '1'}
      # all data
      all = domestic_sold_product(condition)
      domestic["sold_all_cnt"] = all["sold_cnt"]
      domestic["sold_all_amount"] = all["sold_amount"]
      domestic["sold_all_profit"] = all["profit_amount"]
      domestic["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      condition = {"is_domestic" => 1, "year_s" => t.strftime("%Y"),
          "month_s" => 1, "year_e" => t.strftime("%Y"), "month_e" => 12,
          "sold_flg" => '1'
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
          "month_e" => t.strftime("%m"), "sold_flg" => '1'
      }
      # data of current month
      month = domestic_sold_product(condition)
      domestic["sold_month_cnt"] = month["sold_cnt"]
      domestic["sold_month_amount"] = month["sold_amount"]
      domestic["sold_month_profit"] = month["profit_amount"]
      domestic["sold_month_profit_rate"] = month["profit_rate"]
      return domestic
    end

    # auction_info function
    def auction_info
      auction = {}
      # ------------- sold data --------------------
      # all auction data(sold)
      auction["sold_all_cnt"] = count_auction(1, 0)
      auction["sold_all_amount"] = sum_auction(1, 0, 2)
      # auction data of current year(sold)
      auction["sold_year_cnt"] = count_auction(1, 1)
      auction["sold_year_amount"] = sum_auction(1, 1, 2)
      # auction date of current month(sold)
      auction["sold_month_cnt"] = count_auction(1, 2)
      auction["sold_month_amount"] = sum_auction(1, 2, 2)
      # ------------- bought data --------------------
      # all auction data(bought)
      auction["bought_all_cnt"] = count_auction(0, 0)
      auction["bought_all_amount"] = sum_auction(0, 0, 2)
      # auction data of current year(bought)
      auction["bought_year_cnt"] = count_auction(0, 1)
      auction["bought_year_amount"] = sum_auction(0, 1, 2)
      # auction date of current month(bought)
      auction["bought_month_cnt"] = count_auction(0, 2)
      auction["bought_month_amount"] = sum_auction(0, 2, 2)
      return auction
    end

    # custom_info function
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
      custom["general_all_sum"] = sum_custom(0, 0, 0)
      # custom data of current year(general)
      custom["general_year"] = count_custom(0, 1)
      custom["general_year_sum"] = sum_custom(0, 1, 0)
      # custom date of current month(general)
      custom["general_month"] = count_custom(0, 2)
      custom["general_month_sum"] = sum_custom(0, 2, 0)
      return custom
    end

    # shipment_info function
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

    # undeal_product_info function
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

    # undeal_auction_info function
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

    # undeal_custom_info function
    def undeal_custom_info
      custom = {}
      # product unregist
      custom["product_unregist"] =  Custom \
          .joins("LEFT OUTER JOIN pc_maps ON pc_maps.custom_id = customs.custom_id") \
          .where("pc_maps.product_id is null").count
      return custom
    end

    # shipment_status_info function
    def shipment_status_info
      shipment = {}
      # shipment sending
      shipment["sending"] = Shipment.where(arrived_date: nil).count
      # shipment sending
      shipment["arrived"] = Shipment.where.not(arrived_date: nil).count
      return shipment
    end

    # ---------------------- utilities function(LEVEL 1) --------------------------
    # count_auction function
    # * sold_flg 0:bought 1:sold
    # * date_type 0:all 1:year 2:month
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

    # sum auction
    # * sold_flg 0:bought, 1:sold
    # * date_type 0:all 1:year 2:month
    # * domestic_flg 0:offshore, 1:domestic, 2:both
    def sum_auction(sold_flg, date_type, domestic_flg)
      # use plus if bought
      auction = Auction.select("SUM(price * (tax_rate + 100) / 100 + " \
          + "COALESCE(payment_cost, 0) + COALESCE(shipment_cost, 0)) as amount") if sold_flg == 0
      # use minus if sold
      auction = Auction.select("SUM(price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) as amount") if sold_flg == 1
      # for domestic_flg
      auction = auction.joins(" LEFT OUTER JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .joins(" LEFT JOIN products ON pa_maps.product_id = products.product_id ") if domestic_flg != 2
      # for domestic_flg
      auction = auction.where(" (products.is_domestic is null or products.is_domestic != 0) ") if domestic_flg == 1
      auction = auction.where(" products.is_domestic = 0 ") if domestic_flg == 0
      # for sold_flg
      auction = auction.where(sold_flg: sold_flg)
      # all
      return auction.reorder('').first.amount.to_i if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return auction.where("end_time >= :date_s", {:date_s => beginning_date}) \
          .where("end_time <= :date_e", {:date_e => end_date}).reorder('').first.amount.to_i
    end

    # count_custom fuction
    # * is_auction 0:not_auction 1:auction
    # * date_type 0:all 1:year 2:month
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
          .where("regist_date >= :date_s", {:date_s => beginning_date}) \
          .where("regist_date <= :date_e", {:date_e => end_date}).all.count
    end

    # sum_custom function
    # * is_auction 0:not_auction 1:auction
    # * date_type 0:all 1:year 2:month
    # * cancel_flg 0:all 1:only cancel, 2:cancel excluded
    def sum_custom(is_auction, date_type, cancel_flg)
      custom = Custom.select("SUM(COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) " \
          + " + COALESCE(other_cost, 0)) as amount").where(is_auction: is_auction)
      custom = custom.where(" (cancel_flg is null or cancel_flg = 0) ") if cancel_flg == 2
      custom = custom.where(cancel_flg: 1) if cancel_flg == 1
      # all
      return custom.reorder('').first.amount.to_i if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return custom.where("created_at >= :date_s", {:date_s => beginning_date}) \
          .where("created_at <= :date_e", {:date_e => end_date}).reorder('').first.amount.to_i
    end

    # count_shipment function
    # * date_flg 0:sent_date 1:arrived_date
    # * date_type 0:all 1:year 2:month
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