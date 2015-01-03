#encoding: utf-8
class PaMapsController < ApplicationController
  before_action :logged_in_user, :set_products
  before_action :all_pa_maps, only: [:index, :create, :destroy]
  respond_to :html, :js

  def new
    @pa_map = PaMap.new
    @pa_map.product_id = params[:product_product_id]
  end

  def create
    @pa_map  = PaMap.new(pa_map_params)
    @pa_map.product_id = params[:product_product_id]
    if @pa_map.save
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end
  
  def destroy
    PaMap.find(params[:auction_id]).destroy
    flash.now[:success] = "削除完了しました。"
  end

  private
    def set_products
      @product = Product.find(params[:product_product_id])
    end

    def all_pa_maps
      @pa_maps = PaMap.where(product_id: params[:product_product_id])
    end

    def pa_map_params
      params.require(:pa_map).permit(:auction_id)
    end
end
