#encoding: utf-8

class ProductsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # page index
    page = page_ix_help(params[:page])
    # get product data list with pagination.
    @products = Product.paginate(page: page, per_page: 15)
  end

  # show action
  def show
    # get product data by product_id.
    @product = Product.find(params[:product_id])
    # get auction data
    @auctions = Auction.where(:auction_id => PaMap.where(product_id: params[:product_id])).all
    # get custom data
    @customs = Custom.where(:custom_id => PcMap.where(product_id: params[:product_id])).all
    # get shipment data
    @shipment_details = ShipmentDetail.where(:product_id => params[:product_id]).all
    # get sold data
    @solds = Sold.where(product_id: @product.product_id)
  end

  # new action
  def new
    # product instance
    @product = Product.new()
  end

  # create action
  def create
    @product = Product.new(product_params)
    # save product
    if @product.save
      # flash message
      flash[:success] = "作成完了しました。"
      # redirect to product list page
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
    # update attribute
    if @product.update_attributes(product_params)
      # flash message
      flash[:success] = "更新完了しました。"
      # redirect to product list page
      redirect_to products_path
    else
      render 'edit'
    end
  end

  # delete action
  def destroy
    # delete product
    Product.find(params[:product_id]).destroy
    # flash message
    flash[:success] = "削除完了しました。"
    # redirect to product list page
    redirect_to products_path
  end

  private
    # strong parameters method.
    def product_params
      params.require(:product).permit(
        :product_name, :is_domestic, :exchange_rate, :category_id, :brand_id, :modu_id, :memo)
    end
end
