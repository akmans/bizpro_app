# encoding: utf-8
class ModusController < ApplicationController
  before_action :logged_in_user

  # 新規
  def new
    @brand = Brand.find(params[:brand_brand_id])
    # 新フォーム用
    @modu = Modu.new
  end
  
  def index
    @brand = Brand.find(params[:brand_brand_id])
    #debugger
    # カテゴリー全体
    @modus = Modu.where(brand_id: @brand.brand_id).paginate(page: params[:page], :per_page => 15)
  end
  
#  # 表示
#  def show
#    @modu = Modu.find(params[:modu_id])
#  end
  
  # 作成
  def create
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.new(modu_params)
    @modu.modu_id = generate_modu_id(@brand.brand_id)
    @modu.brand_id = @brand.brand_id
    if @modu.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to brand_modus_path
    else
      render 'new'
    end
  end
  
  # 編集
  def edit
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.find(params[:modu_id])
  end
  
  # 更新
  def update
    @brand = Brand.find(params[:brand_brand_id])
    @modu = Modu.find(params[:modu_id])
    if @modu.update_attributes(modu_params)
      flash[:success] = "更新完了しました。"
      redirect_to brand_modus_path
    else
      render 'edit'
    end
  end
  
  # 削除
  def destroy
    Modu.find(params[:modu_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to brand_modus_path
  end
  
  # プライベート関数
  private
    # パラメーター関数
    def modu_params
      params.require(:modu).permit(:modu_name)
    end
    
    # カテゴリーID生成関数
    def generate_modu_id(brand_id)
      max_id = Modu.where(brand_id: brand_id).maximum(:modu_id)
      return "M" + brand_id[1..3] + "001" if max_id.nil?
      next_id = max_id[4,6].to_i + 1
      return max_id[0..3] + "00" + next_id.to_s if next_id < 10
      return max_id[0..3] + "0" + next_id.to_s if next_id < 100
      return max_id[0..3] + next_id.to_s
    end
end
