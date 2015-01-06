# encoding: utf-8
class PaymethodsController < ApplicationController
  before_action :logged_in_user
  before_action :set_paymethods, only: [:edit, :update, :destroy]
#  after_action :all_paymethods, only: [:index, :create, :update, :destroy]
  respond_to :html, :js
  
  def index
    all_paymethods
  end
  
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
      all_paymethods
    else
      render 'new'
    end
  end

  # update action
  def update
    if @paymethod.update_attributes(paymethod_params)
      flash.now[:success] = "更新完了しました。"
      all_paymethods
    else
      render 'edit'
    end
  end
  
  # destory action
  def destroy
    @paymethod.destroy
    flash.now[:success] = "削除完了しました。"
    all_paymethods
  end
  
  private
    # all paymethods
    def all_paymethods
      par = Rack::Utils.parse_query URI(request.env['HTTP_REFERER']).query if request.env['HTTP_REFERER']
      page = (params[:page] || (par["page"] if par) || 1).to_i
      @paymethods = Paymethod.paginate(page: page, :per_page => 15)
      @paymethods = Paymethod.paginate(page: (page - 1), :per_page => 15) if (@paymethods.size == 0 && page > 1)
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
