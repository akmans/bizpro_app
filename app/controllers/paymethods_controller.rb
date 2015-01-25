# encoding: utf-8
class PaymethodsController < ApplicationController
  before_action :logged_in_user
  before_action :set_paymethods, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get paymethod data
    all_paymethods
  end

  # show action
  # nil

  # new action
  def new
    # paymethod instance
    @paymethod = Paymethod.new
  end
  
  # create action
  def create
    @paymethod = Paymethod.new(paymethod_params)
    # save paymethod
    if @paymethod.save
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get paymethod data
      all_paymethods
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  def update
    # update attribute
    if @paymethod.update_attributes(paymethod_params)
      # flash message
      flash.now[:success] = "更新完了しました。"
      # get paymethod data
      all_paymethods
    else
      render 'edit'
    end
  end

  # destory action
  def destroy
    # delete paymethod
    @paymethod.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get paymethod data
    all_paymethods
  end
  
  private
    # all paymethods
    def all_paymethods
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Paymethod.all.count < (page - 1) * per_page + 1 && page > 1)
      # paymethod data for list
      @paymethods = Paymethod.paginate(page: page, per_page: per_page)
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
