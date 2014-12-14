module AuctionsHelper
  # Logs in the given user.
  def yahoojp_log_in(auth)
    session[:y_user_id] = auth.uid
    session[:y_token] = auth.credentials.token
    session[:y_refresh_token] = auth.credentials.refresh_token
    session[:y_expires_at] = auth.credentials.expires_at
    session[:y_user_name] = auth.info.name
    session[:y_email] = auth.info.email
  end
  
  # Returns true if the user is logged in Yahoo!Japan, false otherwise.
  def yahoojp_logged_in?
    session[:y_user_id].nil?
  end
  
  # Logs out the current user.
  def yahoojp_log_out
    session.delete(:y_user_id)
    session.delete(:y_token)
    session.delete(:y_refresh_token)
    session.delete(:y_expires_at)
    session.delete(:y_user_name)
    session.delete(:y_email)
  end
  
  # expires at
  def yahoojp_expires_at
    diff = session[:y_expires_at] - DateTime.now.to_i
    '%d:%02d:%02d' % [ diff / 3600, (diff / 60) % 60, diff % 60 ]
  end
  
  # session will expire?
  def yahoojp_will_expire?
    diff = session[:y_expires_at] - DateTime.now.to_i
    diff > 60 ? true : false
  end
  
  # session will expire?
  def yahoojp_expired?
    diff = session[:y_expires_at] - DateTime.now.to_i
    diff < 0 ? true : false
  end
end
