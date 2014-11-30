# encoding: utf-8
class ShipmethodsController < ApplicationController
  before_action :logged_in_user

  # 新規
  def new
    # 新フォーム用
    @shipmethod = Shipmethod.new
  end
  
  def index
    # カテゴリー全体
    @shipmethods = Shipmethod.paginate(page: params[:page], :per_page => 15)
  end
  
#  # 表示
#  def show
#    @shipmethod = Shipmethod.find(params[:shipmethod_id])
#  end
  
  # 作成
  def create
    @shipmethod = Shipmethod.new(shipmethod_params)
    @shipmethod.shipmethod_id = generate_shipmethod_id
    if @shipmethod.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to shipmethods_path
    else
      render 'new'
    end
  end
  
  # 編集
  def edit
    @shipmethod = Shipmethod.find(params[:shipmethod_id])
  end
  
  # 更新
  def update
    @shipmethod = Shipmethod.find(params[:shipmethod_id])
    if @shipmethod.update_attributes(shipmethod_params)
      flash[:success] = "更新完了しました。"
      redirect_to shipmethods_path
    else
      render 'edit'
    end
  end
  
  # 削除
  def destroy
    Shipmethod.find(params[:shipmethod_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to shipmethods_path
  end
  
  # プライベート関数
  private
    # パラメーター関数
    def shipmethod_params
      params.require(:shipmethod).permit(:shipmethod_name)
    end
    
    # カテゴリーID生成関数
    def generate_shipmethod_id
      max_id = Shipmethod.maximum(:shipmethod_id)
      return "S001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + "00" + next_id.to_s if next_id < 10
      return max_id[0] + "0" + next_id.to_s if next_id < 100
      return max_id[0] + next_id.to_s
    end
end
