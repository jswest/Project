class SessionsController < ApplicationController
  
  #force_ssl
  
  def new
    if is_signed_in?
      redirect_to :controller => "users", :action => :show, :id => @current_user.id
    end
  end
  
  def create
    user = User.find_by_email( params[:sessions][:email] )
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      sign_in user
      redirect_to root_url
    else
      flash.now[:notice] = 'Invalid email or password.'
      render "new"

    end
  end
  
  def destroy
    sign_out
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
end