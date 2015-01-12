#encoding: utf-8

class ProductsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # get product data list with pagination.
    @products = Product.paginate(page: params[:page], :per_page => 15)
  end

  def show
    # get product data by product_id.
    @product = Product.find(params[:product_id])
    @auctions = Auction.where(:auction_id => PaMap.where(product_id: params[:product_id]))
    @customs = Custom.where(:custom_id => PcMap.where(product_id: params[:product_id]))
    @solds = Sold.where(product_id: @product.product_id)
  end

  # new action
  def new
    @product = Product.new()
  end

  # create action
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to products_path
    else
      render 'new'
    end
  end

  # edit action
  def edit
    @product = Product.find(params[:product_id])
  end

  # update action
  def update
    @product = Product.find(params[:product_id])
    if @product.update_attributes(product_params)
      flash[:success] = "更新完了しました。"
      redirect_to products_path
    else
      render 'edit'
    end
  end

  # delete action
  def destroy
    Product.find(params[:product_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to products_path
  end

  private
    # strong parameters method.
    def product_params
      params.require(:product).permit(
        :product_name,
        :is_domestic,
        :exchange_rate,
        :category_id,
        :brand_id,
        :modu_id,
        :memo)
    end
end
