class ApplicationController < ActionController::Base
  protect_from_forgery
  #force_ssl
  
  before_filter :current_user
  
  # SESSIONS STUFF
  def sign_in( user )
    cookies[:remember_token] = { :value => user.id, :expires => 20.years.from_now.utc }
    self.current_user = user
  end
  
  def current_user=( user )
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user
    @current_user ||= User.find_by_id( cookies[:remember_token] )
  end
  
  def sign_out
    cookies.delete( :remember_token )
    self.current_user = nil
  end
  
  def is_signed_in?
    return !current_user.nil?
  end
  
  
end
