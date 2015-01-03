class SessionsController < ApplicationController
  # new action
  def new
  end

  # create action
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in_help user
      params[:session][:remember_me] == '1' ? remember_help(user) : forget_help(user)
      redirect_back_or root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # destroy action
  def destroy
    log_out_help if logged_in_help?
    redirect_to login_path
  end
end