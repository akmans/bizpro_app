class CategoriesController < ApplicationController
#  after_action :index, only: [:new, :edit]
  
  # 新規
  def new
    # 新フォーム用
    @category = Category.new
  end
  
  def index
    # カテゴリー全体
    @categories = Category.paginate(page: params[:page], :per_page => 15)
  end
  
#  # 表示
#  def show
#    @category = Category.find(params[:category_id])
#  end
  
  # 作成
  def create
    @category = Category.new(category_params)
    @category.category_id = generate_category_id
    if @category.save
      # カテゴリー全体
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  # 編集
  def edit
    @category = Category.find(params[:category_id])
  end
  
  # プライベート関数
  private
    # パラメーター関数
    def category_params
      params.require(:category).permit(:category_name)
    end
    
    # カテゴリーID生成関数
    def generate_category_id
      max_id = Category.maximum(:category_id)
      next_id = max_id[1,3].to_i + 1
      return max_id[0] + "00" + next_id.to_s if next_id < 10
      return max_id[0] + "0" + next_id.to_s if next_id < 100
      return max_id[0] + next_id.to_s
    end
end
