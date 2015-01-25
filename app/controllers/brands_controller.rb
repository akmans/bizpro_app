# encoding: utf-8
class BrandsController < ApplicationController
  before_action :logged_in_user
  before_action :set_brands, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get brand data
    all_brands
  end

  # show action
  # nil

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
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get brand data
      all_brands
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  def update
    # update attribute
    if @brand.update_attributes(brand_params)
      # falsh message
      flash.now[:success] = "更新完了しました。"
      # get brand data
      all_brands
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete brand
    @brand.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get brand data
    all_brands
  end

  private
    # all brands
    def all_brands
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Brand.all.count < (page - 1) * per_page + 1 && page > 1)
      # brand data for list
      @brands = Brand.paginate(page: page, per_page: per_page)
    end

    # set brands
    def set_brands
      @brand = Brand.find(params[:brand_id])
    end

    # brand params
    def brand_params
      params.require(:brand).permit(:brand_name)
    end
end
