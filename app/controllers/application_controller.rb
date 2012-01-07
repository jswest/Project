class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # SESSIONS STUFF
  def sign_in( user )
    cookies[:remember_token] = { :value => user.id }
    self.current_user = user
  end
  
  def current_user=( user )
    @current_user = user
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
