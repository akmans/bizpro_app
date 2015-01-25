# encoding: utf-8
class ModusController < ApplicationController
  before_action :logged_in_user
  before_action :set_brands, except: [:ajax_modus]
  before_action :set_modus, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get modu data
    all_modus
  end

  # show action
  # nil

  # new action
  def new
    # modu instance
    @modu = Modu.new
  end

  # create action
  def create
    @modu = Modu.new(modu_params)
    @modu.brand_id = @brand.brand_id
    # save modu
    if @modu.save
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get modu data
      all_modus
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # upadte action
  def update
    @modu = Modu.find(params[:modu_id])
    # update attribute
    if @modu.update_attributes(modu_params)
      # flash message
      flash.now[:success] = "更新完了しました。"
      # get modu data
      all_modus
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete modu
    @modu.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get modu data
    all_modus
  end

  # ajax modus action
  def ajax_modus
    # get modu data.
    @modus = Modu.where(brand_id: params[:brand_id])
    render :json => @modus
  end

  private
    # all modus
    def all_modus
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Modu.where(brand_id: @brand.brand_id).count < (page - 1) * per_page + 1 && page > 1)
      # modu data for list
      @modus = Modu.where(brand_id: @brand.brand_id).paginate(page: page, per_page: 15)
    end

    # set brands
    def set_brands
      @brand = Brand.find(params[:brand_brand_id])
    end

    # set modus
    def set_modus
      @modu = Modu.find(params[:modu_id])
    end

    # modu params
    def modu_params
      params.require(:modu).permit(:modu_name)
    end
end