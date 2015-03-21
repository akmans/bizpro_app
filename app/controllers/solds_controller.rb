class SoldsController < ApplicationController
  before_action :logged_in_user
  before_action :set_products
  before_action :set_solds, only: [:edit, :update, :destroy]
  before_action :all_solds, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

  # index action
  # nil

  # show action
  # nil

  # new action
  def new
    # sold instance
    @sold = Sold.new
  end

  # create action
  def create
    @sold = Sold.new(sold_params)
    @sold.product_id = params[:product_product_id]
    # save sold
    if @sold.save
      # update product
      @product.update_attributes(:sold_date => @sold.sold_date)
      # flash message
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # upadte action
  def update
    @sold = Sold.find(params[:id])
    # update attribute
    if @sold.update_attributes(sold_params)
      # update product
      @product.update_attributes(:sold_date => @sold.sold_date)
      # flash message
      flash.now[:success] = "更新完了しました。"
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete sold
    Sold.find(params[:id]).destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
  end

  private
    # all solds
    def all_solds
      # get sold data
      @solds = Sold.where(product_id: @product.product_id).all
    end

    # set products
    def set_products
      @product = Product.find(params[:product_product_id])
    end

    # set solds
    def set_solds
      @sold = Sold.find(params[:id])
    end

    # sold params
    def sold_params
      params.require(:sold).permit(:sold_date, :sold_price, :ship_charge, :other_charge, :memo)
    end

    # refresh sold_date of product
#    def update_product(product_id, sold_date)
#      product = Product.find(product_id)
#      product.update_attributes(:sold_date => sold_date)
#    end
end
