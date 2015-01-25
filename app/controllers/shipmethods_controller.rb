# encoding: utf-8
class ShipmethodsController < ApplicationController
  before_action :logged_in_user
  before_action :set_shipmethods, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get shipmethod data
    all_shipmethods
  end

  # show action
  # nil

  # new action
  def new
    # new instance
    @shipmethod = Shipmethod.new
  end

  # create action
  def create
    @shipmethod = Shipmethod.new(shipmethod_params)
    # save shipmethod
    if @shipmethod.save
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get shipmethod data
      all_shipmethods
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  def update
    # update attribute
    if @shipmethod.update_attributes(shipmethod_params)
      # flash message
      flash.now[:success] = "更新完了しました。"
      # get shipmethod data
      all_shipmethods
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete shipmethod
    @shipmethod.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get shipmethod data
    all_shipmethods
  end

  private
    # all shipmethods
    def all_shipmethods
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Shipmethod.all.count < (page - 1) * per_page + 1 && page > 1)
      # shipmethod data for list
      @shipmethods = Shipmethod.paginate(page: page, per_page: 15)
    end

    # set shipmethods
    def set_shipmethods
      @shipmethod = Shipmethod.find(params[:shipmethod_id])
    end

    # shipmethod params
    def shipmethod_params
      params.require(:shipmethod).permit(:shipmethod_type, :shipmethod_name)
    end
end
