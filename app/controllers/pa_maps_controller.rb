#encoding: utf-8
class PaMapsController < ApplicationController
  before_action :logged_in_user, :set_products
  before_action :all_pa_maps, only: [:index, :create, :destroy]
  respond_to :html, :js

  # index action
  # nil

  # show action
  # nil

  # new action
  def new
    # pa_map instance
    @pa_map = PaMap.new
    @pa_map.product_id = params[:product_product_id]
  end

  # create action
  def create
    @pa_map  = PaMap.new(pa_map_params)
    @pa_map.product_id = params[:product_product_id]
    # save pa_map
    if @pa_map.save
      # flash message
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  # nil

  # destroy action
  def destroy
    # delete pa_map
    PaMap.find(params[:auction_id]).destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
  end

  private
    # all pa_maps
    def all_pa_maps
      @pa_maps = PaMap.where(product_id: params[:product_product_id])
    end

    # set products
    def set_products
      @product = Product.find(params[:product_product_id])
    end

    # pa_map params
    def pa_map_params
      params.require(:pa_map).permit(:auction_id)
    end
end
