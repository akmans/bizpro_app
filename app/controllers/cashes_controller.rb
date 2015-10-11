# encoding: utf-8
class CashesController < ApplicationController
  before_action :logged_in_user
  before_action :set_cashes, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get cash data
    all_cashes
  end

  # show action
  # nil

  # new action
  def new
    # cash instance
    @cash = Cash.new
  end

  # create action
  def create
    @cash = Cash.new(cash_params)
    # save cash
    if @cash.save
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get cash data
      all_cashes
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  def update
    # update attribute
    if @cash.update_attributes(cash_params)
      # flash message
      flash.now[:success] = "更新完了しました。"
      # get cash data
      all_cashes
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete cash
    @cash.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get cash data
    all_cashes
  end

  private
    # all cashes
    def all_cashes
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Cash.all.count < (page - 1) * per_page + 1 && page > 1)
      # cash data for list
      @cashes = Cash.paginate(page: page, per_page: per_page)
    end

    # set cashes
    def set_cashes
      @cash = Cash.find(params[:cash_id])
    end

    # cash params
    def cash_params
      params.require(:cash).permit(:regist_date, :remark, :is_domestic, :is_in, :exchange_rate, :memo, :amount)
    end
end
