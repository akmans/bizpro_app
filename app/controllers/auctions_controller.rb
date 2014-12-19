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
    @auction.price = @auction.price.to_i
    @auction.payment_cost = @auction.payment_cost.to_i
    @auction.shipment_cost = @auction.shipment_cost.to_i
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
    @categories = {"" => "(空白)"}
    Category.all.each do |cc| 
      @categories.merge! cc.as_hash
    end
    @brands = {"" => "(空白)"}
    Brand.all.each do |bb|
      @brands.merge! bb.as_hash
    end
    @modus = {"" => "(空白)"}
    Modu.where(brand_id: @auction.brand_id).each do |mm|
      @modus.merge! mm.as_hash
    end
    @paymethods = {"" => "(空白)"}
    Paymethod.all.each do |pp|
      @paymethods.merge! pp.as_hash
    end
    @shipmethods = {"" => "(空白)"}
    Shipmethod.where(ship_type: 0).each do |ss|
      @shipmethods.merge! ss.as_hash
    end
  end
  
  # update action
  def update
    @auction = Auction.find(params[:auction_id])
    if @auction.update_attributes(auction_params)
      flash[:success] = "更新完了しました。"
      redirect_to auctions_path
    else
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
      auction.is_custom = 0
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
  
  private
    # strong parameters method.
    def auction_params
      params.require(:auction).permit(:auction_name,
                                      :price,
                                      :tax_rate,
                                      :category_id,
                                      :brand_id,
                                      :modu_id,
                                      :sold_flg,
                                      :is_custom,
                                      :paymethod_id,
                                      :payment_cost,
                                      :ship_type,
                                      :shipmethod_id,
                                      :shipment_cost,
                                      :shipment_code,
                                      :memo)
    end
end
