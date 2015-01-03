# encoding: utf-8
class ShipmethodsController < ApplicationController
  before_action :logged_in_user
  before_action :set_shipmethods, only: [:edit, :update, :destroy]
  before_action :all_shipmethods, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

  # new action
  def new
    # new instance
    @shipmethod = Shipmethod.new
  end

  # create action
  def create
    @shipmethod = Shipmethod.new(shipmethod_params)
    if @shipmethod.save
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end

  # update action
  def update
    if @shipmethod.update_attributes(shipmethod_params)
      flash.now[:success] = "更新完了しました。"
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    @shipmethod.destroy
    flash.now[:success] = "削除完了しました。"
  end

  private
    # all shipmethods
    def all_shipmethods
      @shipmethods = Shipmethod.all
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
