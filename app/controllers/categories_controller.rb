# encoding: utf-8
class CategoriesController < ApplicationController
  before_action :logged_in_user
  
  # index action
  def index
    # get all category data with pagination
    @categories = Category.paginate(page: params[:page], :per_page => 15)
  end
  
#  # show action
#  def show
#    @category = Category.find(params[:category_id])
#  end

  # new action
  def new
    # category instance
    @category = Category.new
  end
  
  # create action
  def create
    @category = Category.new(category_params)
#    @category.category_id = generate_category_id
    if @category.save
      flash[:success] = "作成完了しました。"
      # redirct to brand list
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  # edit action
  def edit
    @category = Category.find(params[:category_id])
  end
  
  # update action
  def update
    @category = Category.find(params[:category_id])
    if @category.update_attributes(category_params)
      flash[:success] = "更新完了しました。"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  
  # destroy action
  def destroy
    Category.find(params[:category_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to categories_path
  end
  
  private
    # category params
    def category_params
      params.require(:category).permit(:category_name)
    end
end
