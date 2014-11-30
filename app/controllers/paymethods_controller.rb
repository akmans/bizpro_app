# encoding: utf-8
class PaymethodsController < ApplicationController
  before_action :logged_in_user
  
  # 新規
  def new
    # 新フォーム用
    @paymethod = Paymethod.new
  end
  
  def index
    # カテゴリー全体
    @paymethods = Paymethod.paginate(page: params[:page], :per_page => 15)
  end
  
#  # 表示
#  def show
#    @paymethod = Paymethod.find(params[:paymethod_id])
#  end
  
  # 作成
  def create
    @paymethod = Paymethod.new(paymethod_params)
    @paymethod.paymethod_id = generate_paymethod_id
    if @paymethod.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to paymethods_path
    else
      render 'new'
    end
  end
  
  # 編集
  def edit
    @paymethod = Paymethod.find(params[:paymethod_id])
  end
  
  # 更新
  def update
    @paymethod = Paymethod.find(params[:paymethod_id])
    if @paymethod.update_attributes(paymethod_params)
      flash[:success] = "更新完了しました。"
      redirect_to paymethods_path
    else
      render 'edit'
    end
  end
  
  # 削除
  def destroy
    Paymethod.find(params[:paymethod_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to paymethods_path
  end
  
  # プライベート関数
  private
    # パラメーター関数
    def paymethod_params
      params.require(:paymethod).permit(:paymethod_name)
    end
    
    # カテゴリーID生成関数
    def generate_paymethod_id
      max_id = Paymethod.maximum(:paymethod_id)
      return "P001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + "00" + next_id.to_s if next_id < 10
      return max_id[0] + "0" + next_id.to_s if next_id < 100
      return max_id[0] + next_id.to_s
    end
end
