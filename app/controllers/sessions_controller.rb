class SessionsController < ApplicationController
  # index action
  # nil

  # show action
  # nil

  # new action
  # nil

  # create action
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # authentication
    if user && user.authenticate(params[:session][:password])
      # log in
      log_in_help user
      params[:session][:remember_me] == '1' ? remember_help(user) : forget_help(user)
      # redirect to
      redirect_back_or root_path
    else
      # flash message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # edit action
  # nil

  # update action
  # nil

  # destroy action
  def destroy
    # log out if log in
    log_out_help if logged_in_help?
    # redirect to login page
    redirect_to login_path
  end
end