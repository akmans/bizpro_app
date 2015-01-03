# encoding: utf-8
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  # index action
  def index
    @users = User.paginate(page: params[:page])
  end

  # show action
  def show
    @user = User.find(params[:id])
  end

  # new action
  def new
    @user = User.new
  end

  # create action
  def create
    @user = User.new(user_params)
    if @user.save
      log_in_help @user
      flash[:success] = "ようこそ!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # edit action
  def edit
    @user = User.find(params[:id])
  end

  # update action
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to users_url
  end

  private
    # user params
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user_help?(@user)
    end
end
