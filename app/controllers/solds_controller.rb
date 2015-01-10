class SoldsController < ApplicationController
  before_action :logged_in_user
  before_action :set_products
  before_action :set_solds, only: [:edit, :update, :destroy]
  before_action :all_solds, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

#  # index action
#  def index
#    # get sold data list with pagination.
#    @solds = Sold.paginate(page: params[:page], :per_page => 15)
#  end
  
  # new action
  def new
#    @product = Product.find(params[:product_product_id])
    # sold instance
    @sold = Sold.new
  end

  # create action
  def create
#    @product = Product.find(params[:product_product_id])
    @sold = Sold.new(sold_params)
    @sold.product_id = params[:product_product_id]
    if @sold.save
      flash.now[:success] = "作成完了しました。"
#      # modu list
#      redirect_to brand_modus_path
    else
      render 'new'
    end
  end

#  # edit action
#  def edit
#    @brand = Brand.find(params[:brand_brand_id])
#    @sold = Sold.find(params[:sold_id])
#  end

  # upadte action
  def update
#    @brand = Brand.find(params[:brand_brand_id])
    @sold = Sold.find(params[:id])
    if @sold.update_attributes(sold_params)
      flash.now[:success] = "更新完了しました。"
#      redirect_to brand_modus_path
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    Sold.find(params[:id]).destroy
    flash.now[:success] = "削除完了しました。"
#    debugger
#    redirect_to brand_modus_path
  end

  private
    # all solds
    def all_solds
      par = Rack::Utils.parse_query URI(request.env['HTTP_REFERER']).query if request.env['HTTP_REFERER']
      page = par["page"] if par
      @solds = Sold.where(product_id: @product.product_id).paginate(page: params[:page] || page, :per_page => 15)
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
end
