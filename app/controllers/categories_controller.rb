# encoding: utf-8
class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_categories, only: [:edit, :update, :destroy]
  before_action :all_categories, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

  # new action
  def new
    # category instance
    @category = Category.new
  end

  # create action
  def create
    @category = Category.new(category_params)
    if @category.save
      flash.now[:success] = "作成完了しました。"
    else
      render 'new'
    end
  end

  # update action
  def update
    if @category.update_attributes(category_params)
      flash.now[:success] = "更新完了しました。"
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    @category.destroy
    flash.now[:success] = "削除完了しました。"
  end

  private
    # all categories
    def all_categories
      @categories = Category.all
    end

    # set categories
    def set_categories
      @category = Category.find(params[:category_id])
    end

    # category params
    def category_params
      params.require(:category).permit(:category_name)
    end
end
