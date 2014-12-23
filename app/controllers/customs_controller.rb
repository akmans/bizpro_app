#encoding: utf-8
class CustomsController < ApplicationController
  before_action :logged_in_user
  
  # new action
  def new
    @custom = Custom.new
    @auctions = auctions_hash
  end

  # index action
  def index
    # get auction data list with pagination.
    @customs = Custom.paginate(page: params[:page], :per_page => 15)
  end

  def show
    # get custom data by custom_id.
    @custom = Custom.find(params[:custom_id])
  end

  def create
    @custom = Custom.new(custom_params)
    @custom.auction_id = nil if @custom.is_auction == 0
    @custom.percentage = nil if @custom.is_auction == 0
    @custom.custom_id = generate_custom_id
    if @custom.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to customs_path
    else
      @auctions = auctions_hash
      render 'new'
    end
  end
  
  # edit action
  def edit
    @custom = Custom.find(params[:custom_id])
    @auctions = auctions_hash # if @custom.is_auction == 0
#    @auctions = auction_less_percentage_hash(@custom.percentage) if @custom.is_auction == 1
  end
  
  # update action
  def update
    @custom = Custom.find(params[:custom_id])
    @custom.auction_id = nil if @custom.is_auction == 0
    @custom.percentage = nil if @custom.is_auction == 0
    if @custom.update_attributes(custom_params)
      flash[:success] = "更新完了しました。"
      redirect_to customs_path
    else
      @auctions = auctions_hash
      render 'edit'
    end
  end
  
  # delete action
  def destroy
    Custom.find(params[:custom_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to customs_path
  end
  
  # ajax auction percentage
  def ajax_auction_percentage
    render :json => auction_percentage_hash(params[:auction_id])
  end

  private
    # strong parameters method.
    def custom_params
      params.require(:custom).permit(:custom_name,
                                     :is_auction,
                                     :auction_id,
                                     :percentage,
                                     :net_cost,
                                     :tax_cost,
                                     :other_cost,
                                     :memo)
    end
    
    def generate_custom_id
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      begin
        string = (0...12).map { o[rand(o.length)] }.join
      end until !Custom.exists?(:custom_id => string)
      string
    end
end
