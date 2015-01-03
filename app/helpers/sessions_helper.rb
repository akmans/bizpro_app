module SessionsHelper
  # Logs in the given user.
  def log_in_help(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember_help(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns true if the given user is the current user.
  def current_user_help?(user)
    user == current_user_help
  end

  # Returns the current logged-in user (if any).
  def current_user_help
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in_help user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in_help?
    !current_user_help.nil?
  end

  # Forgets a persistent session.
  def forget_help(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out_help
    forget_help(current_user_help)
    session.delete(:user_id)
    @current_user = nil
  end

  # Stores the URL trying to be accessed.
  def store_location_help
    session[:forwarding_url] = request.url if request.get?
  end
end