#encoding: utf-8
class CustomsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # get auction data list with pagination.
    @customs = Custom.paginate(page: params[:page], :per_page => 15)
  end

  # show action
  def show
    # get custom data by custom_id.
    @custom = Custom.find(params[:custom_id])
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
  
  # delete action
  def destroy
    Custom.find(params[:custom_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to customs_path
  end
  
  # ajax customs action
  def ajax_customs
    # get custom data.
    render :json => customs_hash_help
  end
  
  # ajax auction percentage
  def ajax_auction_percentage
    render :json => auction_percentage_hash(params[:auction_id])
  end

  private
    # strong parameters method.
    def custom_params
      params.require(:custom)
            .permit(
              :custom_name,
              :is_auction,
              :auction_id,
              :percentage,
              :net_cost,
              :tax_cost,
              :other_cost,
              :memo)
    end
end
