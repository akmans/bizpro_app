#encoding: utf-8
class PcMapsController < ApplicationController
  before_action :logged_in_user, :set_products
  before_action :all_pc_maps, only: [:index, :create, :destroy]
  respond_to :html, :js

  # index action
  # nil

  # show action
  # nil

  # new action
  def new
    # pc_map instance
    @pc_map = PcMap.new
    @pc_map.product_id = params[:product_product_id]
  end

  # create action
  def create
    @pc_map  = PcMap.new(pc_map_params)
    @pc_map.product_id = params[:product_product_id]
    # save pc_map
    if @pc_map.save
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
    # delete pc_map
    PcMap.find(params[:custom_id]).destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
  end

  private
    # all pc_maps
    def all_pc_maps
      @pc_maps = PcMap.where(product_id: params[:product_product_id])
    end

    # set products
    def set_products
      @product = Product.find(params[:product_product_id])
    end

    # pc_map params
    def pc_map_params
      params.require(:pc_map).permit(:custom_id)
    end
end
