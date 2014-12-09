# encoding: utf-8
require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require "base64"

class AuctionsController < ApplicationController
  def new
    @auction = Auction.new
  end

  def index
  end

  def show
#    basic_auth(params)
  end
  
  # 作成
  def create
    @auction = Auction.new(auction_params)
    ydata = getYahooAuctionData(@auction.auction_id)
    if ydata.nil?
      flash.now[:danger] = "データ見つかりません。"
      render 'new'
    else
      jdata = eval(jdata)
    end
    if @brand.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to brands_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  def callback
    auth = request.env['omniauth.auth']
                @user_id = auth.uid

                @name  = auth.info.name
                @email = auth.info.email
                @first_name = auth.info.first_name
                @last_name  = auth.info.last_name

                @token         = auth.credentials.token;
                @refresh_token = auth.credentials.refresh_token;
                @expires_at    = auth.credentials.expires_at;

                render 'sessions/callback'
  end
  
  private
    # パラメーター関数
    def auction_params
      params.require(:auction).permit(:auction_id)
    end

    def getYahooAuctionData(aid)
      url = 'http://auctions.yahooapis.jp/AuctionWebService/V2/auctionItem'
      appid = 'nVjHwfaxg67GfZT54goll2ElU7h7Qo_S9HNO23XlMdPAqa_d.laamR6j788Beg--'
      params = {:appid => appid,
                :output => 'xml',
                :callback => nil,
                :auctionID => aid}
      uri = URI(url)
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      return Hash.from_xml(res.body.gsub("\n", ""))  if res.is_a?(Net::HTTPSuccess)
      return nil
    end
end
