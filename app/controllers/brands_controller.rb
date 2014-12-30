# encoding: utf-8
class BrandsController < ApplicationController
  before_action :logged_in_user
  
  # index action
  def index
    # get all brand data with pagination
    @brands = Brand.paginate(page: params[:page], :per_page => 15)
  end
  
#  # show action
#  def show
#    @brand = Brand.find(params[:brand_id])
#  end
  
  # new action
  def new
    # brand instance
    @brand = Brand.new
  end
  
  # create action
  def create
    @brand = Brand.new(brand_params)
    # save brand
    if @brand.save
      flash[:success] = "作成完了しました。"
      # redirct to brand list
      redirect_to brands_path
    else
      render 'new'
    end
  end
  
  # edit action
  def edit
    @brand = Brand.find(params[:brand_id])
  end
  
  # update action
  def update
    @brand = Brand.find(params[:brand_id])
    if @brand.update_attributes(brand_params)
      flash[:success] = "更新完了しました。"
      redirect_to brands_path
    else
      render 'edit'
    end
  end
  
  # destroy action
  def destroy
    Brand.find(params[:brand_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to brands_path
  end
  
  private
    # brand params
    def brand_params
      params.require(:brand).permit(:brand_name)
    end
end
