# encoding: utf-8
class ModusController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    @brand = Brand.find(params[:brand_brand_id])
    # modu data with pagination
    @modus = Modu.where(brand_id: @brand.brand_id).paginate(page: params[:page], :per_page => 15)
  end

#  # show action
#  def show
#    @modu = Modu.find(params[:modu_id])
#  end

  # new action
  def new
    @brand = Brand.find(params[:brand_brand_id])
    # modu instance
    @modu = Modu.new
  end

  # create action
  def create
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.new(modu_params)
    @modu.brand_id = @brand.brand_id
    if @modu.save
      flash[:success] = "作成完了しました。"
      # modu list
      redirect_to brand_modus_path
    else
      render 'new'
    end
  end

  # edit action
  def edit
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.find(params[:modu_id])
  end

  # upadte action
  def update
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.find(params[:modu_id])
    if @modu.update_attributes(modu_params)
      flash[:success] = "更新完了しました。"
      redirect_to brand_modus_path
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    Modu.find(params[:modu_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to brand_modus_path
  end

  # ajax modus action
  def ajax_modus
    # get modu data.
    @modus = Modu.where(brand_id: params[:brand_id])
    render :json => @modus
  end

  private
    # modu params
    def modu_params
      params.require(:modu).permit(:modu_name)
    end
end