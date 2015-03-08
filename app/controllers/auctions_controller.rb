# encoding: utf-8
require 'faraday'

class AuctionsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    page = page_ix_help(params[:page])
    # get auction data list with pagination.
    @auctions = Auction.paginate(page: page, per_page: 15)
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
    render :json => auctions_hash_help(params[:ope_flg])
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
end
