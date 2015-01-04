#encoding: utf-8
class PcMapsController < ApplicationController
  before_action :logged_in_user, :set_products
  before_action :all_pc_maps, only: [:index, :create, :destroy]
  respond_to :html, :js

  def new
    @pc_map = PcMap.new
    @pc_map.product_id = params[:product_product_id]
  end

  def create
    @pc_map  = PcMap.new(pc_map_params)
    @pc_map.product_id = params[:product_product_id]
    if @pc_map.save
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end
  
  def destroy
    PcMap.find(params[:custom_id]).destroy
    flash.now[:success] = "削除完了しました。"
  end

  private
    def set_products
      @product = Product.find(params[:product_product_id])
    end

    def all_pc_maps
      @pc_maps = PcMap.where(product_id: params[:product_product_id])
    end

    def pc_map_params
      params.require(:pc_map).permit(:custom_id)
    end
end
