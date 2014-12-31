#encoding: utf-8

class ProductsController < ApplicationController
  before_action :logged_in_user

  # new action
  def new
    @product = Product.new()
    form_select_hash(@product.product_id)
  end

  # index action
  def index
    # get product data list with pagination.
    @products = Product.paginate(page: params[:page], :per_page => 15)
  end

  def show
    # get product data by product_id.
    @product = Product.find(params[:product_id])
    @category_name = (Category.find(@product.category_id).category_name \
                     if Category.exists?(@product.category_id)) || '-'
    @brand_name = (Brand.find(@product.brand_id).brand_name \
                  if Brand.exists?(@product.brand_id)) || '-'
    @modu_name = (Modu.find(@product.modu_id).modu_name \
                 if Modu.exists?(@product.modu_id)) || '-'
  end

  # 作成
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to products_path
    else
      form_select_hash(@product.product_id)
      render 'new'
    end
  end

  # edit action
  def edit
    @product = Product.find(params[:product_id])
    form_select_hash(@product.brand_id)
  end

  # update action
  def update
    @product = Product.find(params[:product_id])
    if @product.update_attributes(product_params)
      flash[:success] = "更新完了しました。"
      redirect_to products_path
    else
      form_select_hash(@product.product_id)
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
