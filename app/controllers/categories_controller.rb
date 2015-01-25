# encoding: utf-8
class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_categories, only: [:edit, :update, :destroy]
  respond_to :html, :js

  # index action
  def index
    # get category data
    all_categories
  end

  # show action
  # nil

  # new action
  def new
    # category instance
    @category = Category.new
  end

  # create action
  def create
    @category = Category.new(category_params)
    # save category
    if @category.save
      # flash message
      flash.now[:success] = "作成完了しました。"
      # get category data
      all_categories
    else
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  def update
    # update attribute
    if @category.update_attributes(category_params)
      # flash message
      flash.now[:success] = "更新完了しました。"
      # get category data
      all_categories
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    # delete category
    @category.destroy
    # flash message
    flash.now[:success] = "削除完了しました。"
    # get category data
    all_categories
  end

  private
    # all categories
    def all_categories
      # page index
      page = page_ix_help(params[:page]).to_i
      per_page = 15
      page = page - 1 if (Category.all.count < (page - 1) * per_page + 1 && page > 1)
      # category data for list
      @categories = Category.paginate(page: page, per_page: per_page)
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
