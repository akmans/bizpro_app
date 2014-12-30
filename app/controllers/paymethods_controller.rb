# encoding: utf-8
class PaymethodsController < ApplicationController
  before_action :logged_in_user
  
  # index action
  def index
    # get all paymethod data with pagination
    @paymethods = Paymethod.paginate(page: params[:page], :per_page => 15)
  end
  
#  # show action
#  def show
#    @paymethod = Paymethod.find(params[:paymethod_id])
#  end
  
  # new action
  def new
    # paymethod instance
    @paymethod = Paymethod.new
  end
  
  # create action
  def create
    @paymethod = Paymethod.new(paymethod_params)
    if @paymethod.save
      flash[:success] = "作成完了しました。"
      # redirct to paymethod list
      redirect_to paymethods_path
    else
      render 'new'
    end
  end
  
  # edit action
  def edit
    @paymethod = Paymethod.find(params[:paymethod_id])
  end
  
  # update action
  def update
    @paymethod = Paymethod.find(params[:paymethod_id])
    if @paymethod.update_attributes(paymethod_params)
      flash[:success] = "更新完了しました。"
      redirect_to paymethods_path
    else
      render 'edit'
    end
  end
  
  # destory action
  def destroy
    Paymethod.find(params[:paymethod_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to paymethods_path
  end
  
  private
    # paymethod params
    def paymethod_params
      params.require(:paymethod).permit(:paymethod_name)
    end
end
