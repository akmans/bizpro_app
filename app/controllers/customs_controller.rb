#encoding: utf-8
class CustomsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # get page index
    page = page_ix_help(params[:page])
    # refresh search condition
    @condition = refresh_customs_search_condition_help(params)
    # get custom data.
    @customs = search_custom(@condition, page)
  end

  # show action
  def show
    # get custom data by custom_id.
    @custom = Custom.find(params[:custom_id])
    pc_maps = PcMap.where(custom_id: params[:custom_id]).first
    @product_id = pc_maps.product_id unless pc_maps.nil?
  end

  # new action
  def new
    @custom = Custom.new
  end

  # create action
  def create
    @custom = Custom.new(custom_params)
    @custom.auction_id = nil if @custom.is_auction == 0
    @custom.percentage = nil if @custom.is_auction == 0
    if @custom.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to customs_path
    else
      render 'new'
    end
  end

  # edit action
  def edit
    @custom = Custom.find(params[:custom_id])
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
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # get all custom map data related to custom.
    pc_maps = PcMap.where(custom_id: params[:custom_id]).count
    if pc_maps == 0
      # delete custom
      Custom.find(params[:custom_id]).destroy
      # flash message
      flash[:success] = "削除完了しました。"
    else
      # flash message
      flash[:danger] = "関連データがあるため、削除失敗しました。"
    end
    redirect_to customs_path
  end

  # search action
  def search
    # get parameters from params and save it into session
    @condition = refresh_customs_search_condition_help(params)
    # get custom data list with pagination.
    @customs = search_custom(@condition, 1)
    # render index page
    render 'index'
  end

  # ajax customs action
  def ajax_customs
    # get custom data.
    render json: customs_hash_help
  end

  # ajax auction percentage
  def ajax_auction_percentage
    rtn = {}
    end_time = {}
    auction = Auction.find(params[:auction_id])
    end_time["year"] = auction.end_time.year
    end_time["month"] = auction.end_time.month
    end_time["day"] = auction.end_time.day
    rtn["end_time"] = end_time
    rtn["percentage"] = auction_percentage_hash_help(params[:custom_id], params[:auction_id])
    render json: rtn
  end

  # ajax popup custom
  def ajax_popup_custom
    # call show
    show
    # render page
    render 'popup_custom'
  end

  private
    # strong parameters method.
    def custom_params
      params.require(:custom)
            .permit(:custom_name, :is_auction, :auction_id,:percentage,
                    :net_cost, :tax_cost, :other_cost, :memo, :regist_date, :cancel_flg)
    end

    # search custom
    def search_custom(condition, page_ix)
      # construct where condition
      custom = VCustom
      # custom_name
      custom = custom.where("custom_name like :custom_name", \
                {:custom_name => "%#{condition['custom_name']}%"}) \
                unless condition["custom_name"].blank?
      # is_auction
      custom = custom.where(is_auction: condition["is_auction"]) \
                unless condition["is_auction"].blank?
      # product_unregist
      custom = custom.where("regist_status <> '-'") if condition["product_unregist"] == '0'
      custom = custom.where("pc_maps.custom_id = '-'") if condition["product_unregist"] == '1'
      # start year month
      if !condition["year_s"].blank? && !condition["month_s"].blank?
        date_s = Date::strptime(condition["year_s"] + condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
        custom = custom.where("regist_date >= :created_at", {:created_at => date_s})
      end
      # end year month
      if !condition["year_e"].blank? && !condition["month_e"].blank?
        date_e = Date::strptime(condition["year_e"] + condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d")
        custom = custom.where("regist_date <= :created_at", {:created_at => date_e.end_of_month})
      end
      # auction_id
      custom = custom.where("auction_id = :auction_id", {:auction_id => condition["auction_id"]}) \
          unless condition["auction_id"].blank?
      # paginate
      custom.paginate(page: page_ix, per_page: 15)
    end
end
