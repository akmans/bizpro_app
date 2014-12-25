# encoding: utf-8
require 'faraday'

class AuctionsController < ApplicationController
  before_action :logged_in_user
  
  # new action
  def new
  end

  # index action
  def index
    # get auction data list with pagination.
    @auctions = Auction.paginate(page: params[:page], :per_page => 15)
  end

  # show action
  def show
    # get auction data by auction_id.
    @auction = Auction.find(params[:auction_id])
    @category_name = (Category.find(@auction.category_id).category_name \
                     if Category.exists?(@auction.category_id)) || '-'
    @brand_name = (Brand.find(@auction.brand_id).brand_name \
                  if Brand.exists?(@auction.brand_id)) || '-'
    @modu_name = (Modu.find(@auction.modu_id).modu_name \
                 if Modu.exists?(@auction.modu_id)) || '-'
    @shipmethod_name = (Shipmethod.find(@auction.shipmethod_id).shipmethod_name \
                 if Shipmethod.exists?(@auction.shipmethod_id)) || '-'
    @paymethod_name = (Paymethod.find(@auction.paymethod_id).paymethod_name \
                 if Paymethod.exists?(@auction.paymethod_id)) || '-'
  end
  
#  def create
#  end

  # edit action
  def edit
    @auction = Auction.find(params[:auction_id])
    form_select_hash(@auction.brand_id)
  end
  
  # update action
  def update
    @auction = Auction.find(params[:auction_id])
    if params[:auction][:is_product] == "1" and !Product.exists?(product_id: params[:auction_id])
#    debugger
      @product = Product.new()
      @product.product_id = params[:auction_id]
      @product.is_domestic = 1
      @product.exchange_rate = 0
      @product.category_id = params[:category_id]
      @product.brand_id = params[:brand_id]
      @product.modu_id = params[:modu_id]
      @product.save
    end
    if @auction.update_attributes(auction_params)
      flash[:success] = "更新完了しました。"
      redirect_to auctions_path
    else
      form_select_hash(@auction.brand_id)
      render 'edit'
    end
  end
  
  # delete action
  def destroy
    Auction.find(params[:auction_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to auctions_path
  end
  
  # loaddata action.
  def loaddata
    # faraday options.
    options = {:url => 'https://auctions.yahooapis.jp/AuctionWebService/V2/myWonList',
               :params => {:output => "xml",
                           :access_token => session[:y_token],
                           :start => 1}
    }
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
      auction.price = rs["WonPrice"].to_i
      auction.tax_rate = 0
      auction.seller_id = rs["Seller"]["Id"]
      auction.url = rs["AuctionItemUrl"]
      auction.end_time = DateTime.iso8601(rs["EndTime"])
      auction.sold_flg = 0
      auction.ope_flg = nil
      auction.ship_type = 0
      if !Auction.exists?(auction.auction_id)
        auction.save
      end
    end
    # redirect to auction list page.
    redirect_to auctions_path
  end
  
  # callback action.
  def callback
    auth = request.env['omniauth.auth']
    yahoojp_log_in auth
    render 'new'
  end
  
  # logout action.
  def logout
    yahoojp_log_out
    render 'new'
  end
  
  # ajax auctions action
  def ajax_auctions
    # get auction data.
    render :json => auctions_hash
  end
  
  private
    # strong parameters method.
    def auction_params
      params.require(:auction).permit(
        :auction_name,
        :price,
        :tax_rate,
        :category_id,
        :brand_id,
        :modu_id,
        :sold_flg,
        :ope_flg,
        :is_product,
        :paymethod_id,
        :payment_cost,
        :ship_type,
        :shipmethod_id,
        :shipment_cost,
        :shipment_code,
        :memo)
    end
end
