# encoding: utf-8
require 'faraday'
require 'faraday_middleware'
#require 'uri'
#require 'json'
#require "base64"

class AuctionsController < ApplicationController
  def new
  end

  def index
    # オークション全体
    @auctions = Auction.paginate(page: params[:page], :per_page => 15)
  end

  def show
    @auction = Auction.find(params[:auction_id])
  end
  
  def create
  end
  
  # load yahoo japan data
  def loaddata
    options = {:url => 'https://auctions.yahooapis.jp/AuctionWebService/V2/myWonList',
               :params => {:output => "xml",
                           :access_token => session[:y_token],
                           :start => 1}
    }
    conn = Faraday.new(options) do |builder|
      builder.response :logger #logging stuff
      builder.adapter  :net_http #default adapter for Net::HTTP
      builder.response :xml, :content_type => /\bxml$/ #cool for parsing response bodies
    end
#    debugger
    response = conn.get
    
#    auctions = []
    
#    ActiveRecord::Base.transaction do 
    response.body["ResultSet"]["Result"].each do |rs|
      auction = Auction.new
      auction.auction_id = rs["AuctionID"]
      auction.auction_name = rs["Title"]
      auction.price = rs["WonPrice"].to_i
      auction.seller_id = rs["Seller"]["Id"]
      auction.url = rs["AuctionItemUrl"]
      auction.end_time = DateTime.iso8601(rs["EndTime"])
      auction.sold_flg = 0
      if !Auction.exists?(auction.auction_id)
        auction.save
      end
#      auctions << auction
    end
#    auctions[1].save
    
#  end
#      debugger
    
#    Auction.import auctions
    redirect_to auctions_path
  end

  def edit
    @auction = Auction.find(params[:auction_id])
    @auction_types = {0 => "買い品", 1 => "売り品"}
  end
  
  # 更新
  def update
    @auction = Auction.find(params[:auction_id])
    @auction_types = {0 => "買い品", 1 => "売り品"}
    if @auction.update_attributes(auction_params)
      flash[:success] = "更新完了しました。"
      redirect_to auctions_path
    else
      render 'edit'
    end
  end
  
#  def callback
#    keys = ENV["YAHOOJP_KEY"] + "/" + ENV["YAHOOJP_SECRET"]
#    encode = Base64.encode64(keys)
#    uri = URI.parse(ENV["TOKEN_ENDPOINT"])
#    debugger
#      data = {:grant_type => "authorization_code",
#                :code => params[:code],
#                :redirect_uri => ENV["REDIRECT_URI"]}
#    options = {:url => ENV["TOKEN_ENDPOINT"],
#               :headers => {'Content-Type' => 'application/x-www-form-urlencoded'},
#               :params => data
#    }
#    
#    conn = Faraday.new(options) do |builder|
#      builder.response :logger #logging stuff
#      builder.adapter  :net_http #default adapter for Net::HTTP
#      builder.request :basic_auth, ENV["YAHOOJP_KEY"], ENV["YAHOOJP_SECRET"]
#      builder.use FaradayMiddleware::ParseJson #cool for parsing response bodies
#    end
#    
#    conn.basic_auth(ENV["YAHOOJP_KEY"], ENV["YAHOOJP_SECRET"])
#    conn.headers['Authorization']
#    
#    res = conn.post do |request|
#      request.url uri.request_uri
#      request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
#      request.headers['Authorization'] = 'Basic ' + encode
#      request.body = data
#    end
#    debugger
#
#    res = conn.post #(uri.request_uri, data)
#    do |req|
#      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
#    end
#    
#    debugger
#    res.body
#  end
  
  # 削除
  def destroy
    Auction.find(params[:auction_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to auctions_path
  end
  
  def callback
    auth = request.env['omniauth.auth']
    yahoojp_log_in auth
    render 'new'
  end
  
  def logout
    yahoojp_log_out
    render 'new'
  end
  
  private
    # パラメーター関数
    def auction_params
      params.require(:auction).permit(:auction_name, :price, :sold_flg, :memo)
    end

#    def getYahooAuctionData(aid)
#      url = 'http://auctions.yahooapis.jp/AuctionWebService/V2/auctionItem'
#      appid = 'nVjHwfaxg67GfZT54goll2ElU7h7Qo_S9HNO23XlMdPAqa_d.laamR6j788Beg--'
#      params = {:appid => appid,
#                :output => 'xml',
#                :callback => nil,
#                :auctionID => aid}
#      uri = URI(url)
#      uri.query = URI.encode_www_form(params)
#      res = Net::HTTP.get_response(uri)
#      return Hash.from_xml(res.body.gsub("\n", ""))  if res.is_a?(Net::HTTPSuccess)
#      return nil
#    end
    
#    def refresh_token
#      data = {:grant_type => "refresh_token",
#              :refresh_token => session[:y_refresh_token]}
#      options = {:url => ENV["TOKEN_ENDPOINT"],
#                 :headers => {'Content-Type' => 'application/x-www-form-urlencoded'},
#                 :params => data
#      }
#      conn = Faraday.new(options) do |builder|
#        builder.response :logger #logging stuff
#        builder.adapter  :net_http #default adapter for Net::HTTP
#        builder.use FaradayMiddleware::ParseJson #cool for parsing response bodies
#      end
#      debugger
#      res = conn.post
#      debugger
#      res.body
#    end
end
