# encoding: utf-8
require 'faraday'

class AuctionsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # get page index
    page = page_ix_help(params[:page])
    # refresh search condition
    @condition = refresh_auctions_search_condition_help(params)
#    debugger
#    page = page_ix_help(params[:page])
    # get auction data list with pagination.
#    @auctions = Auction.paginate(page: page, per_page: 15)
    @auctions = search_auction(@condition, page)
#    @condition = {}
#    @condition[:category_id] = '123'

#    auction = Auction
#    auction = auction.where(category_id: @condition[:category_id]) unless @condition[:category_id].blank?
#    @auctions = auction.paginate(page: @condition["page_ix"], per_page: 15)
  end

  # show action
  def show
    # get auction data by auction_id.
    @auction = Auction.find(params[:auction_id])
  end

  # new action
  def new
  end

  # create action
  # nil

  # edit action
  def edit
    @auction = Auction.find(params[:auction_id])
  end

  # update action
  def update
#    debugger
    @auction = Auction.find(params[:auction_id])
    # update auction attributes
    if @auction.update_attributes(auction_params)
      # create product and pa_map if checked
      if params[:auction][:create_product] == "1"
        # for product
        product = Product.new()
        product.product_id = "P" + params[:auction_id]
        product.product_name = params[:auction][:auction_name]
        product.is_domestic = 1
        product.exchange_rate = 0
        product.category_id = params[:auction][:category_id]
        product.brand_id = params[:auction][:brand_id]
        product.modu_id = params[:auction][:modu_id]
        product.sold_date = @auction.end_time if @auction.sold_flg == 1
        product.save
        # for pa_map
        pa_map = PaMap.new()
        pa_map.auction_id = params[:auction_id]
        pa_map.product_id = product.product_id
        pa_map.save
      end
      # set flash message
      flash[:success] = "更新完了しました。"
      redirect_to auctions_path
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    Auction.find(params[:auction_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to auctions_path
  end

  # search action
  def search
    # get parameters from params and save it into session
    @condition = refresh_auctions_search_condition_help(params)
    # get auction data list with pagination.
    @auctions = search_auction(@condition, 1)
    # render index page
    render 'index'
  end

  # load won data action.
  def load_won_data
    # call loaddata
    loaddata(0)
    # redirect to auction list page
    redirect_to auctions_path
  end

  # load closed data action.
  def load_closed_data
    # call loaddata
    loaddata(1)
    # redirect to auction list page
    redirect_to auctions_path
  end

  # callback action.
  def callback
    auth = request.env['omniauth.auth']
    yahoojp_log_in_help auth
    render 'new'
  end

  # logout action.
  def logout
    yahoojp_log_out_help
    render 'new'
  end

  # ajax auctions action
  def ajax_auctions
    # get auction data.
#    render :json => auctions_hash_help(params[:ope_flg])
    render :json => auctions_hash_help(params[:auction_id])
  end

  private
    # strong parameters method.
    def auction_params
      params
        .require(:auction)
        .permit(:auction_name, :price, :tax_rate, :category_id, :brand_id, :modu_id,
                :sold_flg, :ope_flg, :paymethod_id, :payment_cost, :ship_type,
                :shipmethod_id, :shipment_cost, :shipment_code, :memo
        )
    end

    # load data from remote server
    def loaddata(type)
      # faraday options.
      options = {:url => 'https://auctions.yahooapis.jp/AuctionWebService/V2/myWonList',
                 :params => {:output => "xml",
                             :access_token => session[:y_token],
                             :start => 1}
      }
      # for closed list
      if type == 1
        pr = {:output => "xml",
              :access_token => session[:y_token],
              :start => 1,
              :list => 'sold'
        }
        options.merge!(:url => 'https://auctions.yahooapis.jp/AuctionWebService/V2/myCloseList',
                       :params => pr)
      end
      # connection by faraday.
      conn = Faraday.new(options) do |builder|
        builder.response :logger #logging stuff
        builder.adapter  :net_http #default adapter for Net::HTTP
        builder.response :xml, :content_type => /\bxml$/ #cool for parsing response bodies
      end
      # do get request.
      response = conn.get
      # get response data and insert into table if not exists.
      response.body["ResultSet"]["Result"].each do |rs|
        auction = Auction.new
        auction.auction_id = rs["AuctionID"]
        auction.auction_name = rs["Title"]
        auction.price = (type == 1 ? rs["HighestPrice"].to_i : rs["WonPrice"].to_i)
        auction.tax_rate = 0
        auction.seller_id = (type == 1 ? rs["Winner"]["Id"] : rs["Seller"]["Id"])
        auction.url = rs["AuctionItemUrl"]
        auction.end_time = DateTime.iso8601(rs["EndTime"])
        auction.sold_flg = type
        auction.ope_flg = nil
        auction.ship_type = 0
        if !Auction.exists?(auction.auction_id)
          auction.save
        end
      end if response.body["ResultSet"]["totalResultsReturned"] != "0"
    end

  # search auction
  def search_auction(condition, page_ix)
#    debugger
    # construct where condition
    auction = Auction
    # undeal auction (product unregist: 1)
    auction = auction.joins("LEFT OUTER JOIN pa_maps ON auctions.auction_id = pa_maps.auction_id") \
          .where("pa_maps.product_id is null").where(ope_flg: 1) if condition["undeal_auction"] == '1'
    # category_id
    auction = auction.where(category_id: condition["category_id"]) unless condition["category_id"].blank?
    # auction_name
    auction = auction.where("auction_name like :auction_name", \
              {:auction_name => "%#{condition['auction_name']}%"}) unless condition["auction_name"].blank?
    # start year month
    if !condition["year_s"].blank? && !condition["month_s"].blank?
      date_s = Date::strptime(condition["year_s"] + condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      auction = auction.where("end_time >= :end_time", {:end_time => date_s})
    end
    # end year month
    if !condition["year_e"].blank? && !condition["month_e"].blank?
      date_e = Date::strptime(condition["year_e"] + condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      auction = auction.where("end_time <= :end_time", {:end_time => date_e.end_of_month})
    end
    # sold_type
    auction = auction.where(sold_flg: condition["sold_type"]) unless condition["sold_type"].blank?
    # undeal auction(ope_flg is nil: 0)
    auction = auction.where(ope_flg: nil) if condition["undeal_auction"] == '0'
    # undeal auction(custom unregist: 2)
    auction = auction.where(ope_flg: 0).where.not(auction_id: Custom.select("auction_id, SUM(percentage)") \
          .where("auction_id is not null").reorder('').group("auction_id") \
          .having("SUM(percentage) = 100").pluck(:auction_id)) if condition["undeal_auction"] == '2'
#    debugger
    # paginate
    auction.paginate(page: page_ix, per_page: 15)
  end
end
