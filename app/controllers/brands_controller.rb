# encoding: utf-8
class BrandsController < ApplicationController
  # 新規
  def new
    # 新フォーム用
    @brand = Brand.new
  end
  
  def index
    # カテゴリー全体
    @brands = Brand.paginate(page: params[:page], :per_page => 15)
  end
  
#  # 表示
#  def show
#    @brand = Brand.find(params[:brand_id])
#  end
  
  # 作成
  def create
    @brand = Brand.new(brand_params)
    @brand.brand_id = generate_brand_id
    if @brand.save
      flash[:success] = "作成完了しました。"
      # カテゴリー全体
      redirect_to brands_path
    else
      render 'new'
    end
  end
  
  # 編集
  def edit
    @brand = Brand.find(params[:brand_id])
  end
  
  # 更新
  def update
    @brand = Brand.find(params[:brand_id])
    if @brand.update_attributes(brand_params)
      flash[:success] = "更新完了しました。"
      redirect_to brands_path
    else
      render 'edit'
    end
  end
  
  # 削除
  def destroy
    Brand.find(params[:brand_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to brands_path
  end
  
  # プライベート関数
  private
    # パラメーター関数
    def brand_params
      params.require(:brand).permit(:brand_name)
    end
    
    # カテゴリーID生成関数
    def generate_brand_id
      max_id = Brand.maximum(:brand_id)
      return "B001" if max_id.nil?
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + "00" + next_id.to_s if next_id < 10
      return max_id[0] + "0" + next_id.to_s if next_id < 100
      return max_id[0] + next_id.to_s
    end
end
