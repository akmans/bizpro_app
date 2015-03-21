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
    # undeal
    @summary["undeal_product"] = undeal_product_info
    @summary["undeal_auction"] = undeal_auction_info
    @summary["undeal_custom"] = undeal_custom_info
    # by date
    @summary["auction"] = auction_info
    @summary["custom"] = custom_info
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
      offshore = {}
      # all--------------------------
      all = offshore_sold_product(0)
      offshore["sold_all_cnt"] = all["sold_cnt"]
      offshore["sold_all_amount"] = all["sold_amount"]
      offshore["sold_all_profit"] = all["profit_amount"]
      offshore["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      year = offshore_sold_product(1)
      offshore["sold_year_cnt"] = year["sold_cnt"]
      offshore["sold_year_amount"] = year["sold_amount"]
      offshore["sold_year_profit"] = year["profit_amount"]
      offshore["sold_year_profit_rate"] = year["profit_rate"]
      # month--------------------------
      month = offshore_sold_product(2)
      offshore["sold_month_cnt"] = month["sold_cnt"]
      offshore["sold_month_amount"] = month["sold_amount"]
      offshore["sold_month_profit"] = month["profit_amount"]
      offshore["sold_month_profit_rate"] = month["profit_rate"]
      return offshore
    end

    # get domesitc sold data info
    def domestic_sold_info
      domestic = {}
      # all--------------------------
      all = domestic_sold_product(0)
      domestic["sold_all_cnt"] = all["sold_cnt"]
      domestic["sold_all_amount"] = all["sold_amount"]
      domestic["sold_all_profit"] = all["profit_amount"]
      domestic["sold_all_profit_rate"] = all["profit_rate"]
      # year--------------------------
      year = domestic_sold_product(1)
      domestic["sold_year_cnt"] = year["sold_cnt"]
      domestic["sold_year_amount"] = year["sold_amount"]
      domestic["sold_year_profit"] = year["profit_amount"]
      domestic["sold_year_profit_rate"] = year["profit_rate"]
      # month--------------------------
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
      product["domesitc_sold_cnt"] = Product.where(is_domestic: 1).where.not(sold_date: nil).count
      # domesitc unsale count
      product["domesitc_unsale_cnt"] = product["domesitc_cnt"].to_i - product["domesitc_sold_cnt"].to_i
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
      return Auction.where(sold_flg: 1) \
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

    # offshore sold product
    def offshore_sold_product(date_type)
      info = {}
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # count product
      info["sold_cnt"] = count_product(date_type, 0)
      # sold data count is 0
      if info["sold_cnt"] == 0 then
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(sold)
        info["sold_amount"] = Sold.select("SUM(COALESCE(sold_price, 0))" \
            + " - SUM(COALESCE(ship_charge, 0)) - SUM(COALESCE(other_charge, 0)) as amount") \
            .joins("LEFT JOIN products ON solds.product_id = products.product_id") \
            .where("products.is_domestic = 0") \
            .reorder('').first.amount.to_i if date_type == 0
        info["sold_amount"] = Sold.select("SUM(COALESCE(sold_price, 0))" \
            + " - SUM(COALESCE(ship_charge, 0)) - SUM(COALESCE(other_charge, 0)) as amount") \
            .joins("LEFT JOIN products ON solds.product_id = products.product_id") \
            .where("products.is_domestic = 0") \
            .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
            .where("products.sold_date <= :date_e", {:date_e => end_date}) \
            .reorder('').first.amount.to_i if date_type != 0
        # amount(bought) (sold_flg, date_type, is_domestic)
        cost_amount = cost_calculate(date_type, 0)
        # profit amount
        info["profit_amount"] = info["sold_amount"] - cost_amount
        # profit rate
        info["profit_rate"] = (cost_amount != 0 ? (info["profit_amount"] * 100 / cost_amount).round(2) : 0)
      end
      return info
    end

    # domestic sold product
    def domestic_sold_product(date_type)
      info = {}
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # count
      info["sold_cnt"] = count_product(date_type, 1)
      # sold data count is 0
      if info["sold_cnt"] == 0 then
        # amount(sold) = profit amount = profit rate
        info["sold_amount"] = info["profit_amount"] = info["profit_rate"] = 0
      else
        # amount(sold)
        info["sold_amount"] = Auction.select("SUM(price * (tax_rate + 100) / 100 - " \
            + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) as amount") \
            .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
            .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
            .where("products.is_domestic = 1").where(sold_flg: 1).reorder('') \
            .first.amount.to_i if date_type == 0
        info["sold_amount"] = Auction.select("SUM(price * (tax_rate + 100) / 100 - " \
            + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) as amount") \
            .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
            .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
            .where("products.is_domestic = 1").where(sold_flg: 1) \
            .where("sold_date >= :date_s", {:date_s => beginning_date}) \
            .where("sold_date <= :date_e", {:date_e => end_date}).reorder('') \
            .first.amount.to_i if date_type != 0
        # amount(bought) (sold_flg, date_type, is_domestic)
        cost_amount = cost_calculate(date_type, 1)
        # profit amount
        info["profit_amount"] = info["sold_amount"] - cost_amount
        # profit rate
        info["profit_rate"] = (cost_amount != 0 ? (info["profit_amount"] * 100 / cost_amount).round(2) : 0)
      end
      return info
    end

    # ---------------------- utilities function(LEVEL 1) --------------------------
    # count product(date_type 0:all 1:year 2:month)
    def count_product(date_type, is_domestic)
      # all
      return Product.where(is_domestic: is_domestic).where.not(sold_date: nil) \
          .count  if date_type == 0
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # year or month
      return Product.where(is_domestic: is_domestic).where.not(sold_date: nil) \
          .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          .where("products.sold_date <= :date_e", {:date_e => end_date}).count
    end
    
    # cost calculate(date_type 0:all 1:year 2:month)
    def cost_calculate(date_type, is_domestic)
      # date interval
      beginning_date = Time.zone.now.beginning_of_year
      beginning_date = Time.zone.now.beginning_of_month if date_type == 2
      end_date = Time.zone.now.end_of_year
      end_date = Time.zone.now.end_of_month if date_type == 2
      # auction cost
      bought1 = Auction.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount") \
          .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null") \
          .where(sold_flg: 0).reorder('').first.amount.to_f if date_type == 0
      bought1 = Auction.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount") \
          .joins("LEFT JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id ") \
          .joins("LEFT JOIN products ON pa_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          .where("products.sold_date <= :date_e", {:date_e => end_date}) \
          .where(sold_flg: 0).reorder('').first.amount.to_f if date_type != 0
      # custom cost(non auction)
      bought2 = Custom.select("SUM((COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null") \
          .where(is_auction: 0).reorder('').first.amount.to_f if date_type == 0
      bought2 = Custom.select("SUM((COALESCE(net_cost, 0) + COALESCE(tax_cost, 0) + COALESCE(other_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100) as amount") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          .where("products.sold_date <= :date_e", {:date_e => end_date}) \
          .where(is_auction: 0).reorder('').first.amount.to_f if date_type != 0
      # custom cost(auction)
      bought3 = Custom.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) * " \
          + "percentage / 100 / 100) as amount") \
          .joins("LEFT JOIN auctions ON customs.auction_id = auctions.auction_id ") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null") \
          .where(is_auction: 1).reorder('').first.amount.to_f if date_type == 0
      bought3 = Custom.select("SUM((price * (tax_rate + 100) / 100 - " \
          + "COALESCE(payment_cost, 0) - COALESCE(shipment_cost, 0)) * " \
          + "(CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) * " \
          + "percentage / 100 / 100) as amount") \
          .joins("LEFT JOIN auctions ON customs.auction_id = auctions.auction_id ") \
          .joins("LEFT JOIN pc_maps ON customs.custom_id = pc_maps.custom_id ") \
          .joins("LEFT JOIN products ON pc_maps.product_id = products.product_id") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          .where("products.sold_date <= :date_e", {:date_e => end_date}) \
          .where(is_auction: 1).reorder('').first.amount.to_f if date_type != 0
      # offshore shipment cost
      bought4 = ShipmentDetail.select("SUM((COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0) + " \
          + "COALESCE(custom_cost, 0) * 100 / (CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) " \
          + ") * ((CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100)) as amount") \
          .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date is not null") \
          .reorder('').first.amount.to_i if date_type == 0
      bought4 = ShipmentDetail.select("SUM((COALESCE(ship_cost, 0) + COALESCE(insured_cost, 0) + " \
          + "COALESCE(custom_cost, 0) * 100 / (CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) " \
          + ") * ((CASE is_domestic WHEN 0 THEN exchange_rate ELSE 100 END) / 100)) as amount") \
          .joins("LEFT JOIN products ON shipment_details.product_id = products.product_id ") \
          .where("products.is_domestic = :is_domestic", {:is_domestic => is_domestic}) \
          .where("products.sold_date >= :date_s", {:date_s => beginning_date}) \
          .where("products.sold_date <= :date_e", {:date_e => end_date}).reorder('').first.amount.to_i if date_type != 0
      return bought1 + bought2 + bought3 + bought4
    end
end
