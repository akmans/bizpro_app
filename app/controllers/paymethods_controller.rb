# encoding: utf-8
class PaymethodsController < ApplicationController
  before_action :logged_in_user
  before_action :set_paymethods, only: [:edit, :update, :destroy]
  before_action :all_paymethods, only: [:index, :create, :update, :destroy]
  respond_to :html, :js
  
  # new action
  def new
    # paymethod instance
    @paymethod = Paymethod.new
  end
  
  # create action
  def create
    @paymethod = Paymethod.new(paymethod_params)
    if @paymethod.save
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end

  # update action
  def update
    if @paymethod.update_attributes(paymethod_params)
      flash.now[:success] = "更新完了しました。"
    else
      render 'edit'
    end
  end
  
  # destory action
  def destroy
    @paymethod.destroy
    flash.now[:success] = "削除完了しました。"
  end
  
  private
    # all paymethods
    def all_paymethods
      @paymethods = Paymethod.all
    end

    # set paymethods
    def set_paymethods
      @paymethod = Paymethod.find(params[:paymethod_id])
    end

    # paymethod params
    def paymethod_params
      params.require(:paymethod).permit(:paymethod_name)
    end
end
