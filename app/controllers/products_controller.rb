#encoding: utf-8

class ProductsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    @condition = refresh_products_search_condition_help(params)
    # page index
#    page = page_ix_help(params[:page])
    # get product data list with pagination.
#    @products = Product.paginate(page: page, per_page: 15)
    @products = search_product(@condition)
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

  # search action
  def search
    # get parameters from params and save it into session
    @condition = refresh_products_search_condition_help(params)
    # get product data list with pagination.
    @products = search_product(@condition)
    # render index page
    render 'index'
  end

  private
    # strong parameters method.
    def product_params
      params.require(:product).permit(
        :product_name, :is_domestic, :exchange_rate, :category_id, :brand_id, :modu_id, :memo)
    end

  # search product
  def search_product(condition)
    # construct where condition
    product = Product
    # category_id
    product = product.where(category_id: condition["category_id"]) unless condition["category_id"].blank?
    # product_name
    product = product.where("product_name like :product_name", \
              {:product_name => "%#{condition['product_name']}%"}) unless condition["product_name"].blank?
    # start year month
    if !condition["year_s"].blank? && !condition["month_s"].blank?
      date_s = Date::strptime(condition["year_s"] + condition["month_s"] + "01", "%Y%m%d")
      product = product.where(product_id: Sold.where("sold_date >= :sold_date", {:sold_date => date_s}).pluck(:product_id))
    end
    # end year month
    if !condition["year_e"].blank? && !condition["month_e"].blank?
      date_e = Date::strptime(condition["year_e"] + condition["month_e"] + "01", "%Y%m%d")
      product = product.where(product_id: Sold.where("sold_date <= :sold_date", {:sold_date => date_e.end_of_month}).pluck(:product_id))
    end
    # is_domestic
    product = product.where(is_domestic: condition["is_domestic"]) unless condition["is_domestic"].blank?
    # paginate
    product.paginate(page: condition["page_ix"], per_page: 15)
  end
end
